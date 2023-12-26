//
//  Team.swift
//  
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation

public struct Team: Identifiable, Hashable, Sendable {
    public let id: String
    public var teamName: String
    public var avatarId: String?

    public init(
        id: String = UUID().uuidString,
        teamName: String = "",
        avatarId: String? = nil
    ) {
        self.id = id
        self.teamName = teamName
        self.avatarId = avatarId
    }
}
