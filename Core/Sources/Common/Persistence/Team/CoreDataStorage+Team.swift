//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

extension CoreDataStorage: TeamFetching {
    public func fetchTeams() async throws -> [Team] {
        try await perform { context in
            try ManagedTeam.findObjects(in: context)
                .compactMap {
                    $0 as? ManagedTeam
                }
                .map {
                    Team(from: $0)
                }
        }
    }
}

extension CoreDataStorage: TeamCreating {
    public func create(from team: Team) async throws -> Team {
        try await perform { context in
            let managedTeam: ManagedTeam = try .newInstanceIfNeeded(teamId: team.id, in: context)
            managedTeam.update(with: team)
            try context.save()
            return team
        }
    }
}
