//
//  TeamCreationCoordinatorEventHandling.swift
//  Partyvity
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

enum TeamCreationCoordinatorEvent {
    case back
    case startGame
}

protocol TeamCreationCoordinatorEventHandling: AnyObject {
    func handle(event: TeamCreationCoordinatorEvent, from childCoordinator: Coordinator)
}
