//
//  InitialSceneCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation
import Swinject
import UIKit

@MainActor
final class InitialSceneCoordinator {
    var childCoordinators = [Coordinator]()
    let window: UIWindow
    let container: Assembler
    
    init(window: UIWindow, container: Assembler) {
        self.window = window
        self.container = container
    }
}

extension InitialSceneCoordinator: InitialSceneCoordinating {
    
    func start() {
        setLaunchscreenWindow()
    }
}

private extension InitialSceneCoordinator {
    func setLaunchscreenWindow() {
        let launchScreen = R.storyboard.launchScreen(bundle: .main).instantiateInitialViewController()
        window.rootViewController = launchScreen
        window.makeKeyAndVisible()
    }
}

extension InitialSceneCoordinator: AppLifecycleResponding {
    func didDisconnectScene(_ scene: UIScene) {
        childCoordinators.removeAll()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        childCoordinators
            .forEach { ($0 as? AppLifecycleResponding)?.sceneWillEnterForeground(scene) }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        childCoordinators
            .forEach { ($0 as? AppLifecycleResponding)?.sceneDidEnterBackground(scene) }
    }
}
