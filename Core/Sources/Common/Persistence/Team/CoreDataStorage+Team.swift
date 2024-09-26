//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

extension CoreDataStorage: TeamFetching {
    public func fetchTeam(id: String) async throws -> Team? {
        try await perform { context in
            let predicate = NSPredicate(format: "id = %@", id)
            guard let team = try ManagedTeam.find(in: context, predicate: predicate) as? ManagedTeam else {
                return nil
            }

            return Team(from: team)
        }
    }
}

extension CoreDataStorage: TeamCreatingOrUpdating {
    public func createOrUpdate(from team: Team) async throws -> Team {
        try await perform { context in
            let managedTeam: ManagedTeam = try .newInstanceIfNeeded(teamId: team.id, in: context)
            managedTeam.update(with: team)
            try context.save()
            return team
        }
    }
}
