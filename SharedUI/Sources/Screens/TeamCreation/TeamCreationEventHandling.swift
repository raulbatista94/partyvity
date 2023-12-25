//
//  TeamCreationEventHandling.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import Foundation
import Core

public enum TeamCreationEvent {
    case avatarTapped(Team)
    case finished
}

public protocol TeamCreationEventHandling: AnyObject {
    func handle(event: TeamCreationEvent)
}
