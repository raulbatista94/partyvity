//
//  MainMenuCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 15.12.2023.
//

import Foundation
import Swinject
import UIKit
import SharedUI

@MainActor
final class MainMenuCoordinator {
    let navigationController = UINavigationController()
    var childCoordinators = [Coordinator]()
    let container: Assembler
    let window: UIWindow

    init(window: UIWindow, container: Assembler) {
        self.window = window
        self.container = container
    }
}

extension MainMenuCoordinator: NavigationControllerCoordinator {
    func start() {
        let initialScreen = HostingController(
            rootView: MainMenuContainerView(
                viewModel: container.resolver.resolve(
                    MainMenuViewModel.self,
                    argument: self as MainMenuEventHandling
                )!
            )
        )

        navigationController.viewControllers = [initialScreen]
    }

    func openNewGame() {
        let coordinator = CoordinatorsFactory
            .makeGameCoordinator(
                container: container, 
                navigationController: navigationController,
                eventHanlder: self
        )

        startChildCoordinator(coordinator)
    }
}
extension MainMenuCoordinator: SceneCoordinating { }

extension MainMenuCoordinator: TeamCreationEventHandling {
    func handle(event: TeamCreationScreenEvent, from childCoordinator: Coordinator) {
        switch event {
        case .back:
            release(coordinator: childCoordinator)
            navigationController.popViewController(animated: true)
        }
    }
}

extension MainMenuCoordinator: MainMenuEventHandling {
    func handle(event: MainMenuEvent) {
        switch event {
        case .newGameButtonTapped:
            openNewGame()
        case .continueButtonTapped:
            print("Continue tapped")
        case .previousGamesButtonTapped:
            print("Previous games tapped")
        }
    }
}
