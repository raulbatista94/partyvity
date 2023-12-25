//
//  File.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import Foundation
import SwiftUI
import Core

@MainActor
public final class TeamCreationViewModel: ObservableObject {
    @Published var teams = [Team()]
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

    func updateTeam(team: Team, name: String) {
        guard let index = teams.firstIndex(where: { $0.id == team.id }) else { return }
        teams[index].teamName = name
        if name == "" && teams.last?.teamName == "" && teams.count > 1 {
            teams.removeLast()
            return
        }

        addTeamIfNeeded()
    }
}
