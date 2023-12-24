//
//  TeamCreationCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 23.12.2023.
//

import Foundation
import Swinject
import UIKit
import SharedUI

@MainActor
final class TeamCreationCoordinator: NavigationControllerCoordinator {
    
    let navigationController = UINavigationController()
    var childCoordinators = [Coordinator]()
    let container: Assembler

    init(container: Assembler) {
        self.container = container
    }

    func start() { 
        navigationController.viewControllers = [
            ScreenFactory.TeamCreation.makeTeamCreationView(
                container: container,
                eventHandler: self
            )
        ]
    }
}

extension TeamCreationCoordinator: TeamCreationEventHandling {
    func handle(event: TeamCreationEvent) {
        switch event {
        case .avatarTapped(let team):
            print("avatar tapped")
        case .finished:
            print("Finished")
        }
    }
}
