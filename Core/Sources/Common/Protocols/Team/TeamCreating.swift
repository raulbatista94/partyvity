//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

public protocol TeamCreatingOrUpdating: Sendable {
    @discardableResult
    func createOrUpdate(from team: Team) async throws -> Team
}

extension TeamCreatingOrUpdating {
    func createOrUpdate(from teams: [Team]) async throws {
        try await teams.asyncForEach {
            try await createOrUpdate(from: $0)
        }
    }
}
