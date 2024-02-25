//
//  TeamCreationEventHandling.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import Core
import Combine

public enum TeamCreationEvent {
    case avatarTapped((Avatar) -> Void)
    case startGame(Game)
    case back
}
