//
//  MainMenuEventHandling.swift
//  
//
//  Created by Raul Batista on 17.12.2023.
//

import Foundation

public enum MainMenuEvent {
    case newGameButtonTapped
    case continueButtonTapped
    case previousGamesButtonTapped
}

public protocol MainMenuEventHandling: AnyObject {
    func handle(event: MainMenuEvent)
}
