//
//  File.swift
//  
//
//  Created by Raul Batista on 21.01.2024.
//

import Foundation

public struct Game: Identifiable, Hashable, @unchecked Sendable {
    public let id: String
    public var teams: [Team]
    public var gamePhase: String?
    public var currentlySelectedDifficulty: String?
    public var roundSeconds: Double?
    public var currentTeamTurn: Team?
    public var winnerTeam: Team?
    public var currentWord: String?
    public var selectedActivity: String?

    /// Game duration in seconds
    public var gameDuration: Double {
        Date().timeIntervalSince1970 - creationTimestamp
    }

    public let creationTimestamp: Double

    public init(teams: NSMutableOrderedSet) {
        self.id = UUID().uuidString
        self.teams = teams.array as? [Team] ?? []
        self.creationTimestamp = Date().timeIntervalSince1970
    }

    init(from managedObject: ManagedGame) {
        self.id = managedObject.id ?? UUID().uuidString
        self.teams = managedObject.managedTeams?.array as? [Team] ?? []
        self.creationTimestamp = managedObject.creationTimestamp
        self.currentlySelectedDifficulty = managedObject.currentlySelectedDifficulty
        self.roundSeconds = managedObject.roundSeconds
        self.currentWord = managedObject.currentWord
        self.selectedActivity = managedObject.selectedActivity
    }
}
