//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation
import CoreData

@objc(ManagedTeam)
public final class ManagedTeam: NSManagedObject {
    @NSManaged private(set) public var id: String
    @NSManaged private(set) public var avatarId: String
    @NSManaged private(set) public var teamName: String
    @NSManaged private(set) public var score: Int
}

public extension ManagedTeam {
    func updateScore(
        score: Int,
        in context: NSManagedObjectContext
    ) async throws {
        let managedTeam: ManagedTeam = try .newInstanceIfNeeded(teamId: id, in: context)
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

    func fetchTeam(
        teamId: String,
        in context: NSManagedObjectContext
    ) async throws -> ManagedTeam? {
        let predicate = NSPredicate(
            format: "%K == %@",
            #keyPath(ManagedTeam.id),
            id
        )

        do {
            let storedTeam: ManagedTeam? = try Self.find(in: context, predicate: predicate)
            return storedTeam
        } catch {
            throw error
        }
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
