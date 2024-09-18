//
//  MainMenuViewModel.swift
//  
//
//  Created by Raul Batista on 17.12.2023.
//

import Combine
import Foundation

public class MainMenuViewModel: ObservableObject {
    @Published private(set) var gameInProgressAvailable: Bool = false
    private let eventSubject = PassthroughSubject<ViewAction, Never>()

    @MainActor func send(event: Input) {
        switch event {
        case .newGameButtonTapped:
            eventSubject.send(.newGameButtonTapped)
        case .continueButtonTapped:
            eventSubject.send(.continueButtonTapped)
        case .previousGamesButtonTapped:
            eventSubject.send(.previousGamesButtonTapped)
        }
    }

    enum Input {
        case newGameButtonTapped
        case continueButtonTapped
        case previousGamesButtonTapped
    }

    public enum ViewAction {
        case newGameButtonTapped
        case continueButtonTapped
        case previousGamesButtonTapped
    }

    public var eventPublisher: AnyPublisher<ViewAction, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
