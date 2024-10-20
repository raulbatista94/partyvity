//
//  MainMenuViewModel.swift
//  
//
//  Created by Raul Batista on 17.12.2023.
//

import Combine
import Core
import Foundation

@MainActor
public class MainMenuViewModel: ObservableObject {
    @Published private(set) var gameInProgressAvailable: Bool = false
    private let eventSubject = PassthroughSubject<ViewAction, Never>()
    private var game: Game?
    private let gameService: GameServicing

    nonisolated init(gameService: GameServicing) {
        self.gameService = gameService
    }

    @MainActor func send(event: Input) {
        switch event {
        case .viewDidAppear:
            if let gameId = UserDefaults.standard.gameInstance {
                fetchGameInProgress(gameId: gameId)
            }
        case .newGameButtonTapped:
            eventSubject.send(.newGameButtonTapped)
        case .continueButtonTapped:
            guard let game else {
                return
            }
            eventSubject.send(.continueButtonTapped(game))
        case .previousGamesButtonTapped:
            eventSubject.send(.previousGamesButtonTapped)
        }
    }

    enum Input {
        case viewDidAppear
        case newGameButtonTapped
        case continueButtonTapped
        case previousGamesButtonTapped
    }

    public enum ViewAction {
        case newGameButtonTapped
        case continueButtonTapped(Game)
        case previousGamesButtonTapped
    }

    public var eventPublisher: AnyPublisher<ViewAction, Never> {
        eventSubject.eraseToAnyPublisher()
    }

    func fetchGameInProgress(gameId: String) {
        Task { [weak self] in
            if let game = try await self?.gameService.getGame(for: gameId) {
                self?.game = game
                self?.gameInProgressAvailable = true
            }
        }
    }
}
