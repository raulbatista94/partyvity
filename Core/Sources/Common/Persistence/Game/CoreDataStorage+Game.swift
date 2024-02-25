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


//extension CoreDataStorage: TeamFetching {
//    public func fetchTeams() async throws -> [Team] {
//        try await perform { context in
//            try ManagedTeam.findObjects(in: context)
//                .compactMap {
//                    $0 as? ManagedTeam
//                }
//                .map {
//                    Team(from: $0)
//                }
//        }
//    }
//}
//
//extension CoreDataStorage: TeamCreating {
//    public func create(from team: Team) async throws -> Team {
//        try await perform { context in
//            let managedTeam: ManagedTeam = try .newInstanceIfNeeded(teamId: team.id, in: context)
//            managedTeam.update(with: team)
//            try context.save()
//            return team
//        }
//    }
//}
