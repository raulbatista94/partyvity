//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation


public final class TeamService {
    public typealias Storage = TeamCreatingOrUpdating & TeamFetching

    private let storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }

    /// Stores the created teams to the database
    /// - Parameter teams: List of created teams
    public func saveTeams(_ teams: [Team]) async throws {
        try await storage.createOrUpdate(from: teams)
    }

    /// Retrieves the created teams from the database.
    /// - Returns: List of teams
    public func getTeam(id: String) async throws -> Team? {
        try await storage.fetchTeam(id: id)
    }

    public func updateTeam(team: Team) async throws {
        try await storage.createOrUpdate(from: team)
    }
}

public extension TeamService {
    static let mock = TeamService(storage: try! CoreDataStorage(storeURL: URL(string: "localhost")!))
}
