//
//  DIRegistrator.swift
//  SharedUI
//
//  Created by Raul Batista on 15.09.2024.
//

import Core
import Foundation
import Swinject

public enum DIRegistrator {
    public static func registerViewModel(container: Container) {
        container.register(MainMenuViewModel.self) { _ in
            MainMenuViewModel()
        }
        .inObjectScope(.transient)

        container.register(TeamCreationViewModel.self) { resolver in
            TeamCreationViewModel(gameService: resolver.resolve(GameServicing.self)!)
        }
        .inObjectScope(.transient)

        container.register(GameViewModel.self) { (resolver, arg1: [Team]) in
            let (teams) = arg1

            return GameViewModel(
                teams: teams,
                wordService: resolver.resolve(WordProviding.self)!
            )
        }
        .inObjectScope(.transient)
    }
}
