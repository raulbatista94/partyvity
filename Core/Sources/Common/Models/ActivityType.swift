//
//  File.swift
//  
//
//  Created by Raul Batista on 08.09.2024.
//

import Foundation

public enum ActivityType: CaseIterable {
    case describe
    case drawing
    case pantomime

    public var buttonTitle: String {
        switch self {
        case .describe:
            String(localized: "activityType.describe")
        case .drawing:
            String(localized: "activityType.drawing")
        case .pantomime:
            String(localized: "activityType.pantomime")
        }
    }

    public var pointsMultiplier: Int {
        switch self {
        case .describe:
            1
        case .drawing:
            2
        case .pantomime:
            3
        }
    }
}
