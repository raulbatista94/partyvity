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
    
    let navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    let container: Assembler
    let backAction: (Coordinator) -> Void

    init(
        container: Assembler,
        navigationController: UINavigationController? = nil,
        backAction: @escaping (Coordinator) -> Void
    ) {
        self.container = container
        self.navigationController = navigationController ?? UINavigationController()
        self.backAction = backAction
    }

    func start() { 
        let viewController = ScreenFactory.TeamCreation.makeTeamCreationView(
            container: container,
            eventHandler: self
        )

        navigationController.pushViewController(viewController, animated: true)
    }
}

extension TeamCreationCoordinator: TeamCreationEventHandling {
    func handle(event: TeamCreationEvent) {
        switch event {
        case .avatarTapped(let team):
            show(ScreenFactory.TeamCreation.makeAvatarSelectionView(
                avatarSelected: { avatar in

            }, 
                backAction: { [weak self] in
                    self?.navigationController.popViewController(animated: true)
                }))
        case .finished:
            navigationController.topViewController?.dismiss(animated: true)
        case .back:
            navigationController.popViewController(animated: true)
        }
    }
}
