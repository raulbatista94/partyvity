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
    // MARK: - Intro screen
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

    // MARK: - Team creation
    @MainActor
    enum TeamCreation {
        static func makeTeamCreationView(container: Assembler, eventHandler: TeamCreationEventHandling) -> UIViewController {
            let controller = HostingController(
                rootView: TeamCreationViewContainer(
                    viewModel: container.resolver.resolve(TeamCreationViewModel.self)!,
                    eventHandler: eventHandler
                )
            )
            return controller
        }

        static func makeAvatarSelectionView(
            avatarSelected: @escaping (Avatar) -> Void,
            backAction: @escaping () -> Void
        ) -> UIViewController {
            let rootView = AvatarSelectionView(
                avatarSelected: avatarSelected,
                backAction: backAction
            )
            return HostingController(rootView: rootView)
        }
    }
}
