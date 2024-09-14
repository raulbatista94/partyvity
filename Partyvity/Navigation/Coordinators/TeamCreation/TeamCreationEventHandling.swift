//
//  TeamCreationEventHandling.swift
//  Partyvity
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

enum TeamCreationScreenEvent {
    case back
    case startGame
}

protocol TeamCreationEventHandling: AnyObject {
    func handle(event: TeamCreationScreenEvent, from childCoordinator: Coordinator)
}
