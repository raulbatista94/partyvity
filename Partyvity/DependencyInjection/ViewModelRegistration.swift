//
//  ViewModelRegistration.swift
//  Partyvity
//
//  Created by Raul Batista on 18.12.2023.
//

import Foundation
import Swinject
import SharedUI

final class ViewModelRegistration: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(MainMenuViewModel.self) { (_, eventHandler: MainMenuEventHandling) in
            MainMenuViewModel(eventHandler: eventHandler)
        }
        .inObjectScope(.graph)

        container.register(TeamCreationViewModel.self) { _ in
            TeamCreationViewModel()
        }
        .inObjectScope(.graph)
    }
}
