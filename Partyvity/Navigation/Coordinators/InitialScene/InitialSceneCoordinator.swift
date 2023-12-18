//
//  InitialSceneCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation
import Swinject
import SharedUI
import UIKit
import SwiftUI

@MainActor
final class InitialSceneCoordinator {
    var childCoordinators = [Coordinator]()
    let window: UIWindow
    let container: Assembler
    private(set) lazy var navigationController: UINavigationController = UINavigationController()
    
    init(window: UIWindow, container: Assembler) {
        self.window = window
        self.container = container
    }
}

extension InitialSceneCoordinator: InitialSceneCoordinating {
    func start() {
        setLaunchscreenWindow()
        // TOOD: At this point we will check if we will
        // open the main menu or continue game.
        goToMainMenu()
        
    }
}

extension InitialSceneCoordinator: NavigationControllerCoordinator {}

private extension InitialSceneCoordinator {
    func setLaunchscreenWindow() {
        let launchScreen = R.storyboard.launchScreen(bundle: .main).instantiateInitialViewController()
        window.rootViewController = launchScreen
        window.makeKeyAndVisible()
    }
    
    func goToMainMenu() {
        setRootCoordinator(
            CoordinatorsFactory
                .makeMainMenuCoordinator(container: container)
        )
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
