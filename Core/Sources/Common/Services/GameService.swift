//
//  File.swift
//  
//
//  Created by Raul Batista on 25.02.2024.
//

import Foundation

public protocol GameServicing {
    /// Fetches all games.
    /// This function fetches all games from the database. It performs the fetch operation asynchronously.
    /// - Returns: An array of `Game` objects. If no games exist, it returns an empty array.
    /// - Throws: An error if there was an issue fetching the games from the database.
    func getGames() async throws -> [Game]

    /// Fetches a game with the specified ID.
    /// This function fetches a game from the database using the provided ID. 
    /// It performs the fetch operation asynchronously.
    /// - Parameter id: A string value representing the unique identifier of the game to fetch.
    /// - Returns: A `Game` object if a game with the specified ID exists, otherwise returns `nil`.
    func getGame(for id: String) async throws -> Game?

    /// Creates a new game in the data store asynchronously based on the provided game instance.
    /// - Parameter game: An instance of `Game` struct representing the game data to be created.
    /// - Returns: An asynchronous task that resolves to a `Game` instance representing the newly created game.
    func saveGame(_ game: Game) async throws -> Game
}

final class GameService: GameServicing {
    typealias GameStorage = GameCreating & GameFetching
    
    private let storage: GameStorage

    init(storage: GameStorage) {
        self.storage = storage
    }

    public func getGames() async throws -> [Game] {
        try await storage.fetchGames()
    }

    public func getGame(for id: String) async throws -> Game? {
        try await storage.fetchGame(with: id)
    }

    public func saveGame(_ game: Game) async throws -> Game {
        try await storage.create(from: game)
    }
}
