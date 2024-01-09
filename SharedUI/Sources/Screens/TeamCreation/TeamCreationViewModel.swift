//
//  TeamCreationViewModel.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import Foundation
import SwiftUI
import Core

@MainActor
public final class TeamCreationViewModel: ObservableObject {
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

    public nonisolated init() {}

    func addTeam() {
        guard teams.count < 6 else { return }
        teams.append(Team())
    }

    func addTeamIfNeeded() {
        guard
            let lastTeam = teams.last,
            !lastTeam.teamName.isEmpty
        else {
            return
        }
        addTeam()
    }

    func updateTeam(team: Team) {
        guard let index = teams.firstIndex(where: { $0.id == team.id }) else { return }
        teams[index] = team
    }

//    func updateTeamsAvatar(team: Team, avatar: Avatar) {
//        guard let index = teams.firstIndex(where: { $0.id == team.id }) else { return }
//        teams[index].avatarId = avatar.rawValue
//    }
}
