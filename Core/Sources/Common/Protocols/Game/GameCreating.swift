//
//  GameCreating.swift
//
//
//  Created by Raul Batista on 21.01.2024.
//

import Foundation

public protocol GameCreating: Sendable {
    @discardableResult
    func create(from game: Game) async throws -> Game
}
