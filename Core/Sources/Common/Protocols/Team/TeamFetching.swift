//
//  File.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

public protocol TeamFetching {
    func fetchTeam(id: String) async throws -> Team?
}
