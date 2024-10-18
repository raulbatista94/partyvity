//
//  File.swift
//  
//
//  Created by Raul Batista on 21.01.2024.
//

import Foundation
import CoreData

extension CoreDataStorage: GameFetching {
    public func fetchGames() async throws -> [Game] {
        try await perform { context in
            try ManagedGame.findObjects(in: context)
                .compactMap {
                    $0 as? ManagedGame
                }
                .map {
                    Game(from: $0)
                }
        }
    }

    public func fetchGame(with id: String) async throws -> Game? {
        try await perform { context in
            let predicate = NSPredicate(format: "id = %@", id)
            guard let managedGame = try ManagedGame.find(in: context, predicate: predicate) as? ManagedGame else {
                return nil
            }

            return Game(from: managedGame)
        }
    }
}

extension CoreDataStorage: GameCreating {
    public func create(from game: Game) async throws -> Game {
        try await perform { context in
            let managedGame: ManagedGame = try .newInstanceIfNeeded(in: context)
            managedGame.update(with: game, context: context)
            try context.save()
            return game
        }
    }
}
