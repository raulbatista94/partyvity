//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

public final class TeamService {
    public typealias Storage = TeamCreating & TeamFetching

    private let storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }

    /// Stores the created teams to the database
    /// - Parameter teams: List of created teams
    public func saveTeams(_ teams: [Team]) async throws {
        try await storage.create(from: teams)
    }

    /// Retrieves the created teams from the database.
    /// - Returns: List of teams
    public func getTeams() async throws -> [Team] {
        try await storage.fetchTeams()
    }
}
