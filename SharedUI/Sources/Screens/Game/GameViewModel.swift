//
//  File.swift
//  
//
//  Created by Raul Batista on 22.06.2024.
//

import Core
import Combine
import SwiftUI

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
    private var currentDifficulty: WordDifficulty = .baby
    private var timer: AnyCancellable?
    private let teamService: TeamService

    private let wordService: WordProviding

    let teams: [Team]
    private let colors = [
            Color.blueLight,
            Color.carmineRed,
            Color.teamOrange,
            Color.teamPurple,
            Color.yellowBorder,
            Color.textInputActive
    ]

    var currentTeamColor: Color {
        let indexOfCurrentTeam = teams.firstIndex(where: { $0.id == currentTurnTeam.id }) ?? .zero
        return colors[indexOfCurrentTeam]
    }

    public init(
        teams: [Team],
        wordService: WordProviding,
        teamService: TeamService
    ) {
        self.teams = teams
        self.wordService = wordService
        self.teamService = teamService

        guard let firstTeam = teams.first else {
            assertionFailure("This can't happen. We shouldn't be able to access this screen without ")
            currentTurnTeam = Team()
            return
        }

        // No need to fetch it from DB at this point since it should be a fresh team.
        currentTurnTeam = firstTeam
    }

    @MainActor func send(input: Input) {
        switch input {
        case .viewDidAppear:
            currentWord = wordService.randomWord(for: currentDifficulty)
        case let .didTapActivity(selectedActivity):
            self.selectedActivity = selectedActivity
            gamePhase = .guessing
        case .advanceToNextWord:
            timer?.cancel()
            earnedPointsThisTurn += (1 * (selectedActivity?.pointsMultiplier ?? 1))
            currentDifficulty = currentDifficulty.nextDifficulty()
            currentWord = wordService.randomWord(for: currentDifficulty)
            if currentDifficulty == .nightmare {
                gamePhase = .roundEvaluation
            }
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
        Task { @MainActor [weak self] in
            guard let self else {
                return
            }
            
            self.currentTurnTeam.updatePoints(gainedPoints: earnedPointsThisTurn)
            try await teamService.updateTeam(team: currentTurnTeam)
            self.earnedPointsThisTurn = .zero
            self.remainingTime = 60
            self.currentDifficulty = .baby
            self.gamePhase = .activityPicking

            let idToFetch: String
            if
                let indexOfCurrentTeam = teams.firstIndex(where: { $0.id == self.currentTurnTeam.id }),
                indexOfCurrentTeam + 1 < teams.count {
                idToFetch = teams[indexOfCurrentTeam + 1].id
            } else {
                idToFetch = teams.first!.id
            }

            let teamFromDatabase = try await teamService.getTeam(id: idToFetch)
            currentTurnTeam = teamFromDatabase ?? teams[0]
            print("current turn team \(currentTurnTeam) ")
        }
    }

    func evaluateRound() {
        gamePhase = .roundEvaluation
        
        Task { [weak self] in
            guard let self else {
                return
            }

            try await Task.sleep(for: .seconds(5))
            if self.gamePhase == .roundEvaluation {
                self.finishRound()
            }
        }
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
        case viewDidAppear
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
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Potkanice",
            avatarId: Avatar.avatarLOL.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "slonice",
            avatarId: Avatar.avatarGeek.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Prdice",
            avatarId: Avatar.avatarWink.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Prstenice",
            avatarId: Avatar.avatarAngry.rawValue
        )
    ]
}
