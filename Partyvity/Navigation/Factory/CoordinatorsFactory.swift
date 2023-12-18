//
//  CoordinatorsFactory.swift
//  Partyvity
//
//  Created by Raul Batista on 07.12.2023.
//

import Foundation
import Swinject
import UIKit

protocol GameEventHandling {
    
}
@MainActor
enum CoordinatorsFactory {
    static func makeMainMenuCoordinator(
        container: Assembler
    ) -> ViewControllerCoordinator {
        MainMenuCoordinator(container: container)
    }
    static func makeGameCoordinator(
        window: UIWindow,
        eventHandler: GameEventHandling,
        container: Assembler
    ) -> Coordinator {
        // TODO: Replace this with the Game coordinator later
        InitialSceneCoordinator(window: window, container: container)
    }
}


