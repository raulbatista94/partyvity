//
//  File.swift
//  
//
//  Created by Raul Batista on 08.09.2024.
//

import Foundation

public enum ActivityType: String, CaseIterable {
    case describe
    case drawing
    case pantomime

    public var buttonTitle: String {
        switch self {
        case .describe:
            String(localized: "activityType.describe", bundle: Bundle.module)
        case .drawing:
            String(localized: "activityType.drawing", bundle: Bundle.module)
        case .pantomime:
            String(localized: "activityType.pantomime", bundle: Bundle.module)
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
