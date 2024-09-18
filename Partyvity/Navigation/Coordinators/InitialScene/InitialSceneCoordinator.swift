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
    let resolver: Resolver
    private(set) lazy var navigationController: UINavigationController = UINavigationController()
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
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
                .makeMainMenuCoordinator(
                    window: window,
                    resolver: resolver
                )
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
