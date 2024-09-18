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
        resolver: Resolver
    ) -> ViewControllerCoordinator {
        MainMenuCoordinator(
            window: window,
            resolver: resolver
        )
    }
    
    static func makeGameCoordinator(
        resolver: Resolver,
        navigationController: UINavigationController?,
        eventHanlder: TeamCreationEventHandling
    ) -> ViewControllerCoordinator {
        GameCoordinator(
            resolver: resolver,
            navigationController: navigationController,
            eventHandler: eventHanlder
        )
    }
}


