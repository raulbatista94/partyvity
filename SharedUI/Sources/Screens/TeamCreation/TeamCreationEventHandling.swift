//
//  TeamCreationEventHandling.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import Foundation
import Core

public enum TeamCreationEvent {
    case avatarTapped((Avatar) -> Void)
    case startGame
    case back
}

public protocol TeamCreationEventHandling: AnyObject {
    func handle(event: TeamCreationEvent)
}
