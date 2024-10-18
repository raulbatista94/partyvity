//
//  MainMenuCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 15.12.2023.
//

import Core
import Combine
import Foundation
import Swinject
import UIKit
import SharedUI

@MainActor
final class MainMenuCoordinator {
    let navigationController = UINavigationController()
    var childCoordinators = [Coordinator]()
    let resolver: Resolver
    let window: UIWindow

    private lazy var cancellables = Set<AnyCancellable>()

    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
}

extension MainMenuCoordinator: NavigationControllerCoordinator {
    func start() {
        let viewModel = resolver.resolve(MainMenuViewModel.self)!
        
        let initialScreen = HostingController(
            rootView: MainMenuContainerView(
                viewModel: viewModel
            )
        )

        viewModel.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        navigationController.viewControllers = [initialScreen]
    }

    func openNewGame(game: Game? = nil) {
        let coordinator = CoordinatorsFactory
            .makeGameCoordinator(
                resolver: resolver,
                navigationController: navigationController,
                eventHanlder: self
        ) as? GameCoordinator

        if let game {
            coordinator?.gameFlow(game: game)
        } else {
            coordinator?.teamCreationFlow()
        }

        startChildCoordinator(coordinator!)
    }
}
extension MainMenuCoordinator: SceneCoordinating { }

extension MainMenuCoordinator: TeamCreationEventHandling {
    func handle(event: TeamCreationScreenEvent, from childCoordinator: Coordinator) {
        switch event {
        case .back:
            release(coordinator: childCoordinator)
            navigationController.popViewController(animated: true)
        }
    }
}

extension MainMenuCoordinator {
    func handle(event: MainMenuViewModel.ViewAction) {
        switch event {
        case .newGameButtonTapped:
            openNewGame()
        case .continueButtonTapped(let game):
            openNewGame(game: game)
        case .previousGamesButtonTapped:
            print("Previous games tapped")
        }
    }
}
