//
//  File.swift
//  
//
//  Created by Raul Batista on 27.09.2024.
//

import Foundation

// `UserDefaults` that is shared between within an app group
public protocol SharedUserDefaults: AnyObject, Sendable {
    var gameInstance: String? { get set }
}

private enum UserDefaultsKeys: String {
    case gameInstance
}

extension UserDefaults: SharedUserDefaults {
    public var gameInstance: String? {
        get {
            value(forKey: UserDefaultsKeys.gameInstance.rawValue) as? String

        }
        set {
            setSynchronized(newValue, forKey: UserDefaultsKeys.gameInstance.rawValue)
        }
    }
}

// MARK: - Helpers
extension UserDefaults {
    func setSynchronized(_ value: Any?, forKey key: String) {
        set(value, forKey: key)
        synchronize()
    }
}
