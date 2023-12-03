//
//  File.swift
//  
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation

public struct Team: Identifiable, Hashable, Sendable {
    public let id: String
    public let teamName: String
    public let avatarId: String

    public init(
        id: String = UUID().uuidString,
        teamName: String,
        avatarId: String
    ) {
        self.id = id
        self.teamName = teamName
        self.avatarId = avatarId
    }
}
