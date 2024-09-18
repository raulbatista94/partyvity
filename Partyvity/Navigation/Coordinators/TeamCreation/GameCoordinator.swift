//
//  GameCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 23.12.2023.
//

import Core
import Combine
import Foundation
import UIKit
import SharedUI
import SwiftUI
import Swinject

@MainActor
final class GameCoordinator: NavigationControllerCoordinator {
    
    let navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    let resolver: Resolver
    var cancellables = Set<AnyCancellable>()

    private weak var eventHandler: TeamCreationEventHandling?

    init(
        resolver: Resolver,
        navigationController: UINavigationController? = nil,
        eventHandler: TeamCreationEventHandling
    ) {
        self.resolver = resolver
        self.navigationController = navigationController ?? UINavigationController()
        self.eventHandler = eventHandler
    }

    func start() { 
        navigationController.pushViewController(makeTeamCreationView(), animated: true)
    }
}

extension GameCoordinator {
    func handle(event: TeamCreationEvent) {
        switch event {
        case let .avatarTapped(avatarAction):
            let avatarView = makeAvatarSelectionView(avatarSelected: avatarAction)

            show(avatarView)
        case let .startGame(game):
            navigationController.setViewControllers([makeGameView(teams: game.teams)], animated: true)
        case .back:
            eventHandler?.handle(event: .back, from: self)
        }
    }
}

// MARK: - Screen factory
extension GameCoordinator {
    func makeTeamCreationView() -> UIViewController {
        let viewModel = resolve(TeamCreationViewModel.self)
        let view = TeamCreationViewContainer(viewModel: viewModel)

        viewModel.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return HostingController(rootView: view)
    }

    func makeAvatarSelectionView(
        avatarSelected: @escaping (Avatar) -> Void
    ) -> UIViewController {
        let rootView = AvatarSelectionView(avatarSelected: avatarSelected) { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        return HostingController(rootView: rootView)
    }

    func makeGameView(teams: [Team]) -> UIViewController {
        let viewModel = resolve(GameViewModel.self, argument: teams)

        let view = GameView(viewModel: viewModel)

        return HostingController(rootView: view)
    }
}
