//
//  File.swift
//  
//
//  Created by Raul Batista on 22.06.2024.
//

import Core
import Combine
import SwiftUI

@MainActor
public final class GameViewModel: ObservableObject {
    enum GamePhase {
        case activityPicking
        case guessing
        case roundEvaluation
    }

    @Published var currentTurnTeam: Team
    @Published var earnedPointsThisTurn: Int = .zero
    @Published var gamePhase: GamePhase = .activityPicking
    @Published var currentWord: String?
    @Published var remainingTime: Int = 60

    private var selectedActivity: ActivityType?
    private var timer: AnyCancellable?

    let teams: [Team]

    public init(teams: [Team]) {
        self.teams = teams
        guard let firstTeam = teams.first else {
            assertionFailure("This can't happen. We shouldn't be able to access this screen without ")
            currentTurnTeam = Self.mockTeams.first!
            return
        }
        currentTurnTeam = firstTeam
    }

    func send(input: Input) {
        switch input {
        case let .didTapActivity(selectedActivity):
            self.selectedActivity = selectedActivity
            gamePhase = .guessing
        case .advanceToNextWord:
            // TODO: - Handle the advance to next word logic
            evaluateRound()
        case .wordDidAppear:
            startCountDown()
        case .didFinishRound:
            finishRound()
        }
    }
}

// MARK: - Private API
private extension GameViewModel {
    func finishRound() {
        currentTurnTeam.updatePoints(gainedPoints: earnedPointsThisTurn)
        earnedPointsThisTurn = .zero
        gamePhase = .activityPicking

        guard
            let indexOfCurrentTeam = teams.firstIndex(of: currentTurnTeam),
            indexOfCurrentTeam + 1 < teams.count // means the next index would be out
        else {
            currentTurnTeam = teams.first!
            return
        }

        currentTurnTeam = teams[indexOfCurrentTeam + 1]
    }

    func evaluateRound() {
        gamePhase = .roundEvaluation
    }

    func startCountDown() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else {
                    return
                }

                if self.remainingTime > .zero {
                    self.remainingTime -= 1
                } else {
                    self.timer?.cancel()
                    self.evaluateRound()
                    self.remainingTime = 60
                }
            }
    }
}

// MARK: - Events
extension GameViewModel {
    enum Input {
        case didTapActivity(ActivityType)
        case advanceToNextWord
        case wordDidAppear
        case didFinishRound
    }
}

extension GameViewModel {
    static let mockTeams = [
        Team(
            id: UUID().uuidString,
            teamName: "Klokani",
            avatarId: Avatar.avatarAlert.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Klokanice",
            avatarId: Avatar.avatarCash.rawValue
        )
    ]
}
