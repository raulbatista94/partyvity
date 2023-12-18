//
//  ScreenFactory+Initial.swift
//  Partyvity
//
//  Created by Raul Batista on 15.12.2023.
//

import Foundation
import UIKit
import SharedUI
import Swinject

extension ScreenFactory {
    @MainActor
    enum Initial {
        static func makeMainMenuView(container: Assembler, eventHandler: MainMenuEventHandling) -> UIViewController {
            let initialScreen = HostingController(
                rootView: MainMenuContainerView(
                    // swiftlint:disable:next force_unwrapping
                    viewModel: container.resolver.resolve(
                        MainMenuViewModel.self,
                        argument: eventHandler
                    )!
                )
            )
            return initialScreen
        }
    }
}
