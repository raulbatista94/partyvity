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
        container.register(MainMenuViewModel.self) { resolver in
            MainMenuViewModel(
                gameService: resolver.resolve(GameServicing.self)!
            )
        }
        .inObjectScope(.transient)

        container.register(TeamCreationViewModel.self) { resolver in
            TeamCreationViewModel(gameService: resolver.resolve(GameServicing.self)!)
        }
        .inObjectScope(.transient)

        container.register(GameViewModel.self) { (resolver, arg1: Game) in
            let (game) = arg1

            return GameViewModel(
                teams: game.teams,
                game: game,
                wordService: resolver.resolve(WordProviding.self)!,
                teamService: resolver.resolve(TeamService.self)!, 
                gameService: resolver.resolve(GameServicing.self)!
            )
        }
        .inObjectScope(.transient)
    }
}
