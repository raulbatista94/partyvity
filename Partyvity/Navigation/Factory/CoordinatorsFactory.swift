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
        window: UIWindow,
        container: Assembler
    ) -> ViewControllerCoordinator {
        MainMenuCoordinator(
            window: window,
            container: container
        )
    }
    
    static func makeGameCoordinator(
        container: Assembler,
        navigationController: UINavigationController?,
        eventHanlder: TeamCreationEventHandling
    ) -> ViewControllerCoordinator {
        GameCoordinator(
            container: container,
            navigationController: navigationController,
            eventHandler: eventHanlder
        )
    }
}


