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

//extension ManagedTeam {
//    enum CodingKeys: String, CodingKey {
//        case id
//        case avatarId
//        case teamName
//        case score
//    }
//
//    public convenience init(id: String, avatarId: String, teamName: String, score: Int) {
//        self.init()
//        self.id = id
//        self.avatarId = avatarId
//        self.teamName = teamName
//        self.score = score
//    }
//
////    public func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encodeIfPresent(id, forKey: .id)
////        try container.encodeIfPresent(avatarId, forKey: .avatarId)
////        try container.encodeIfPresent(teamName, forKey: .teamName)
////        try container.encodeIfPresent(score, forKey: .score)
////    }
////
////    public convenience init(from decoder: Decoder) throws {
////        self.init()
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////
////        self.id = try container.decode(String.self, forKey: .id)
////        self.avatarId = try container.decode(String.self, forKey: .avatarId)
////        self.teamName = try container.decode(String.self, forKey: .teamName)
////        self.score = try container.decode(Int.self, forKey: .score)
////    }
//}

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
