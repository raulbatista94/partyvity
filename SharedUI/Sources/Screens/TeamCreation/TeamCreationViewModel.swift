//
//  File.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import Foundation
import SwiftUI
import Core

public final class TeamCreationViewModel: ObservableObject {
    @Published var teams = [Team()]

    public init() {}

    func addTeam() {
        guard teams.count < 6 else { return }
        teams.append(Team())
    }

    func handleEditOfLastTeam() {
        if let lastTeam = teams.last {
            if lastTeam.teamName.isEmpty && teams.count > 1 {
                teams.removeLast()
            } else {
                addTeam()
            }
        }
    }
}
