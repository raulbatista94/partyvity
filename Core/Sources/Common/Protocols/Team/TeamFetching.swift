//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

public protocol TeamFetching {
    func fetchTeams() async throws -> [Team]
}
