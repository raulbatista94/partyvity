//
//  NullStorage.swift
//
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

public actor NullStorage {
    var teams: [Team] = []
    public init() {}
}

extension NullStorage: TeamFetching {
    public func fetchTeams() async throws -> [Team] {
        return []
    }
}

extension NullStorage: TeamCreating {
    public func create(from team: Team) async throws -> Team {
        return Team()
    }
}
