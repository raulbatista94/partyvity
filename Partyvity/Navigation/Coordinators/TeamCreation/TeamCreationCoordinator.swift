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
    private weak var eventHandler: TeamCreationCoordinatorEventHandling?

    init(
        container: Assembler,
        navigationController: UINavigationController? = nil,
        eventHandler: TeamCreationCoordinatorEventHandling
    ) {
        self.container = container
        self.navigationController = navigationController ?? UINavigationController()
        self.eventHandler = eventHandler
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
        case .avatarTapped(let avatarSelected):
            show(ScreenFactory.TeamCreation.makeAvatarSelectionView(
                avatarSelected: { [weak self] avatar in
                    avatarSelected(avatar)
                    self?.navigationController.popViewController(animated: true)
                },
                backAction: { [weak self] in
                    self?.navigationController.popViewController(animated: true)
                }))
        case .startGame:
            navigationController.topViewController?.dismiss(animated: true)
        case .back:
            eventHandler?.handle(event: .back, from: self)
        }
    }
}
