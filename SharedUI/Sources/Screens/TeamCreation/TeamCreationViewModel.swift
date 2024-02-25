//
//  TeamCreationViewModel.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import Combine
import Core
import SwiftUI

@MainActor
public final class TeamCreationViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var teams = [Team()] {
        didSet {
            showStartButton = teams.allSatisfy { !$0.teamName.isEmpty && ($0.avatarId != nil) } && teams.count > 1
        }
    }
    @Published var teamSize: Int = 1 {
        didSet {
            let difference = teamSize - teams.count

            if difference > 0 {
            // Add missing teams
                for _ in (0...difference) {
                    addTeam()
                }
            } else {
            // remove the excess
                teams.removeLast(abs(difference))
            }
        }
    }

    @Published var teamTableSize: CGFloat = 0
    @Published var showStartButton: Bool = false

    private(set) var eventSubject = PassthroughSubject<TeamCreationEvent, Never>()
    private lazy var cancellables = Set<AnyCancellable>()
    // MARK: - Dependencies
    private let persistenceService: GameCreating

    public init(persistenceService: GameCreating) {
        self.persistenceService = persistenceService
    }

    func send(_ action: TeamCreationAction) {
        switch action {
        case let .avatarTapped(team):
            eventSubject.send(.avatarTapped { [weak self] selectedAvatar in
                var selectedTeam = team
                selectedTeam.avatarId = selectedAvatar.rawValue
                self?.updateTeam(team: selectedTeam)
            })
        case let .updateTeamName(team):
            updateTeam(team: team)
        case .startGame:
            Task { [weak self] in
                guard let self else {
                    return
                }
                do {
                    let game = try await self.createGame()
                    self.eventSubject.send(.startGame(game))
                } catch {
                    print("Error starting game: \(error.localizedDescription)")
                }
            }
        case .back:
            eventSubject.send(.back)
        }
    }

    private func addTeam() {
        guard teams.count < 6 else { return }
        teams.append(Team())
    }

    private func addTeamIfNeeded() {
        guard
            let lastTeam = teams.last,
            !lastTeam.teamName.isEmpty
        else {
            return
        }
        addTeam()
    }

    private func updateTeam(team: Team) {
        guard let index = teams.firstIndex(where: { $0.id == team.id }) else { return }
        teams[index] = team
    }

    private func createGame() async throws -> Game {
        let newGame = Game(teams: NSMutableOrderedSet(array: teams))
        return try await persistenceService.create(from: newGame)
    }
}

public extension TeamCreationViewModel {
    var eventPublisher: AnyPublisher<TeamCreationEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Actions
extension TeamCreationViewModel {
    enum TeamCreationAction {
        case avatarTapped(Team)
        case updateTeamName(Team)
        case startGame
        case back
    }
}
