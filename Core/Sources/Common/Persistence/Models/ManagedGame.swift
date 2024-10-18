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
    @NSManaged public var gameDuration: Double
    @NSManaged public var roundSeconds: Double
    @NSManaged public var gamePhase: String?
    @NSManaged public var currentWord: String?
    @NSManaged public var currentlySelectedDifficulty: String?
    @NSManaged public var creationTimestamp: Double
    @NSManaged public var selectedActivity: String?
    @NSManaged public var managedTeams: NSOrderedSet?
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
        // Solve correct saving of the teams
        managedTeams = try? NSOrderedSet(array: game.teams.map {
            let managedTeam: ManagedTeam = try ManagedTeam.newInstanceIfNeeded(
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
