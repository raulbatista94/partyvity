//
//  File.swift
//  
//
//  Created by Raul Batista on 22.06.2024.
//

import Core
import SwiftUI

@MainActor
final class GameViewModel: ObservableObject {
    enum GamePhase {
        case activityPicking
        case guessing
        case gameResolving
    }

    @Published var currentTurnTeam: Team
    @Published var earnedPointsThisTurn: Int = .zero
    @Published var gamePhase: GamePhase = .activityPicking

    private var selectedActivity: ActivityType?

    let teams: [Team]

    init(teams: [Team]) {
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
        }
    }
}

// MARK: - Eventz
extension GameViewModel {
    enum Input {
        case didTapActivity(ActivityType)
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
