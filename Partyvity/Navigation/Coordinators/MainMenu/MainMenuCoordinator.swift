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
    
    init(container: Assembler) {
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
}

extension MainMenuCoordinator: MainMenuEventHandling {
    func handle(event: MainMenuEvent) {
        switch event {
        case .newGameButtonTapped:
            print("New game tapped")
        case .continueButtonTapped:
            print("Continue tapped")
        case .previousGamesButtonTapped:
            print("Previous games tapped")
        }
    }
}
