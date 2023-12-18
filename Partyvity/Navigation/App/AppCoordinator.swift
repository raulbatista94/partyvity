//
//  AppCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation
import UIKit
import Swinject

typealias ActiveScene = (scene: UIScene, coordinatorId: ObjectIdentifier?)

@MainActor
final class AppCoordinator {
    var childCoordinators = [Coordinator]()

    private(set) lazy var activeScenes: [ActiveScene] = []

    let container = Assembler()
}

// MARK: - AppCoordinating

extension AppCoordinator: AppCoordinating {
    func start() {
        assembleDependencyInjectionContainer()
    }
}

// MARK: - Assembly

// Extension is internal to be accessible from test target
extension AppCoordinator {
    func assembleDependencyInjectionContainer() {
        container.apply(assemblies: [
            ViewModelRegistration(),
            // TODO: Add remainig
        ])
    }
}

// MARK: Scenes management
extension AppCoordinator {
    func didLaunchScene<Coordinator: SceneCoordinating>(
        _ scene: UIScene,
        window: UIWindow
    ) -> Coordinator {
        let coordinator: Coordinator = makeSceneCoordinator(with: window)

        activeScenes.append((scene: scene, coordinatorId: ObjectIdentifier(coordinator)))
        childCoordinators.append(coordinator)

        return coordinator
    }

    func didDisconnectScene(_ scene: UIScene) {
        removeSceneCoordinator(for: scene)
    }
}

// MARK: Coordinators management
private extension AppCoordinator {
    func makeSceneCoordinator<Coordinator: SceneCoordinating>(with window: UIWindow) -> Coordinator {
        Coordinator(window: window, container: container)
    }

    func removeSceneCoordinator(for scene: UIScene) {
        guard let index = activeScenes.firstIndex(where: { $0.scene == scene }) else {
            return
        }

        let coordinatorId = activeScenes[index].coordinatorId

        // Remove coordinator from child coordinators
        if let index = childCoordinators.firstIndex(where: { ObjectIdentifier($0) == coordinatorId }) {
            childCoordinators.remove(at: index)
        }

        // Remove the scene from the list of active scenes
        activeScenes.remove(at: index)
    }
}
