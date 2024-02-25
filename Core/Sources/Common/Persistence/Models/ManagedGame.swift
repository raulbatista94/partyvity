//
//  ManagedGame+CoreDataClass.swift
//  Partyvity
//
//  Created by Raul Batista on 20.01.2024.
//
//

import Foundation
import CoreData

@objc(ManagedGame)
class ManagedGame: NSManagedObject {
    @NSManaged public var id: String?
    @NSManaged public var teams: NSOrderedSet?
    @NSManaged public var gameDuration: Double
    @NSManaged public var creationTimestamp: Double
}

extension ManagedGame {
    /// Fetches the stored ManagedAppLimit for the specified `appLimitId` or creates a new instance if can't find any.
    static func newInstanceIfNeeded(
        id: String,
        teams: NSOrderedSet,
        in context: NSManagedObjectContext
    ) throws -> ManagedGame {
        let predicate = NSPredicate(
            format: "%K == %@",
            #keyPath(ManagedGame.id),
            id
        )

        let stored: ManagedGame? = try find(
            in: context,
            predicate: predicate
        )

        return stored ?? ManagedGame(context: context)
    }

    static func newInstanceIfNeeded(in context: NSManagedObjectContext) throws -> ManagedGame {
        try find(in: context) ?? ManagedGame(context: context)
    }

    func update(with game: Game, context: NSManagedObjectContext) {
        id = game.id
        teams = try? NSOrderedSet(array: game.teams.map {
            let managedTeam: ManagedTeam = try .newInstanceIfNeeded(
                teamId: $0.id,
                in: context
            )
            managedTeam.update(with: $0)
            return managedTeam
        })
        gameDuration = game.gameDuration
        creationTimestamp = game.creationTimestamp
    }
}
