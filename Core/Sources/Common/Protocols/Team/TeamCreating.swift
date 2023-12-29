//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

public protocol TeamCreating: Sendable {
    @discardableResult
    func create(from team: Team) async throws -> Team
}

extension TeamCreating {
    func create(from teams: [Team]) async throws {
        try await teams.asyncForEach {
            try await create(from: $0)
        }
    }
}
