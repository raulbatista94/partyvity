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
            ScreenFactory.Initial.makeInitialScreen()
        ]
    }
}
