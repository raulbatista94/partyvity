//
//  GameFetching.swift
//  
//
//  Created by Raul Batista on 21.01.2024.
//

import Foundation

public protocol GameFetching {
    func fetchGames() async throws -> [Game]
    func fetchGame(with id: String) async throws -> Game?
}
