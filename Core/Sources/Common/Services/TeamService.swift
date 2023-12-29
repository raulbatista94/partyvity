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

    public func saveTeams(_ teams: [Team]) async throws {
        try await storage.create(from: teams)
    }

    public func getTeams() async throws -> [Team] {
        try await storage.fetchTeams()
    }
}
