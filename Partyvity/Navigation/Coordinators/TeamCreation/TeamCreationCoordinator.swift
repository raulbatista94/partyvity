//
//  TeamCreationCoordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 23.12.2023.
//

import Combine
import Foundation
import UIKit
import SharedUI
import Swinject

@MainActor
final class TeamCreationCoordinator: NavigationControllerCoordinator {
    
    let navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    let container: Assembler
    var cancellables = Set<AnyCancellable>()

    private weak var eventHandler: TeamCreationCoordinatorEventHandling?

    init(
        container: Assembler,
        navigationController: UINavigationController? = nil,
        eventHandler: TeamCreationCoordinatorEventHandling
    ) {
        self.container = container
        self.navigationController = navigationController ?? UINavigationController()
        self.eventHandler = eventHandler
    }

    func start() { 
        navigationController.pushViewController(makeTeamCreationView(), animated: true)
    }
}

extension TeamCreationCoordinator {
    func handle(event: TeamCreationEvent) {
        switch event {
        case let .avatarTapped(avatarAction):
            let avatarView = makeAvatarSelectionView(avatarSelected: avatarAction)

            show(avatarView)
        case .startGame:
            eventHandler?.handle(event: .startGame, from: self)
        case .back:
            eventHandler?.handle(event: .back, from: self)
        }
    }
}

// MARK: - Screen factory
extension TeamCreationCoordinator {
    func makeTeamCreationView() -> UIViewController {
        let viewModel = container.resolver.resolve(TeamCreationViewModel.self)!
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
}
