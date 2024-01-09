//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import CoreData

@objc(ManagedTeam)
final class ManagedTeam: NSManagedObject {
    @NSManaged private(set) var id: String
    @NSManaged private(set) var avatarId: String
    @NSManaged private(set) var teamName: String
    @NSManaged private(set) var score: Int
}

extension ManagedTeam {
    func updateScore(
        score: Int,
        for teamId: String,
        in context: NSManagedObjectContext
    ) async throws {
        let managedTeam: ManagedTeam = try .newInstanceIfNeeded(teamId: teamId, in: context)
        managedTeam.score = score
        try context.save()
    }

    func update(with team: Team) {
        id = team.id
        // Careful, hardcoded value `avatarGeek`. We suppose that it's included in the resources
        // in SharedUI package.
        avatarId = team.avatarId ?? "avatarGeek"
        teamName = team.teamName
        score = team.score
    }
}

extension ManagedTeam {
    /// Fetches the stored ManagedAppLimit for the specified `appLimitId` or creates a new instance if can't find any.
    static func newInstanceIfNeeded(
        teamId: String,
        in context: NSManagedObjectContext
    ) throws -> ManagedTeam {
        let predicate = NSPredicate(
            format: "%K == %@",
            #keyPath(ManagedTeam.id),
            teamId
        )

        let stored: ManagedTeam? = try find(
            in: context,
            predicate: predicate
        )
        return stored ?? ManagedTeam(context: context)
    }
}
