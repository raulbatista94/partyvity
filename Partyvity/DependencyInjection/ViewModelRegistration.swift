//
//  ViewModelRegistration.swift
//  Partyvity
//
//  Created by Raul Batista on 18.12.2023.
//

import Core
import Foundation
import Swinject
import SharedUI

final class ViewModelRegistration: Assembly {
    @MainActor
    func assemble(container: Swinject.Container) {
        container.register(MainMenuViewModel.self) { (_, eventHandler: MainMenuEventHandling) in
            MainMenuViewModel(eventHandler: eventHandler)
        }
        .inObjectScope(.graph)

        container.register(TeamCreationViewModel.self) {
            TeamCreationViewModel(
                gameService: $0.resolve(GameServicing.self)!
            )
        }
        .inObjectScope(.graph)
    }
}
