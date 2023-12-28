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
        navigationController.viewControllers = [
            ScreenFactory.Initial.makeMainMenuView(
                container: container,
                eventHandler: self
            )
        ]
    }

    func openNewGame() {
        let coordinator = CoordinatorsFactory
            .makeTeamCreationCoordinator(
                container: container, 
                navigationController: navigationController,
                backAction: { [weak self] coordinator in
                    self?.release(coordinator: coordinator)
            }
        )

        startChildCoordinator(coordinator)
    }
}
extension MainMenuCoordinator: SceneCoordinating { }

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
