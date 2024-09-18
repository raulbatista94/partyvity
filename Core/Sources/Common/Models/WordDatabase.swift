//
//  File.swift
//  
//
//  Created by Raul Batista on 15.09.2024.
//

public enum WordDifficulty: String, CaseIterable {
    case baby
    case easy
    case medium
    case hard
    case nightmare

    public func nextDifficulty() -> Self {
        switch self {
        case .baby:
            return .easy
        case .easy:
            return .medium
        case .medium:
            return .hard
        case .hard:
            return .nightmare
        case .nightmare:
            return .baby
        }
    }
}

struct WordDatabase: Decodable {
    private var easy: [String]
    private var baby: [String]
    private var medium: [String]
    private var hard: [String]
    private var nightmare: [String]

    subscript(difficulty: WordDifficulty) -> [String] {
        get {
            switch difficulty {
            case .baby:
                return baby
            case .easy:
                return easy
            case .medium:
                return medium
            case .hard:
                return hard
            case .nightmare:
                return nightmare
            }
        }
        set {
            switch difficulty {
            case .baby:
                baby = newValue
            case .easy:
                easy = newValue
            case .medium:
                medium = newValue
            case .hard:
                hard = newValue
            case .nightmare:
                nightmare = newValue
            }
        }
    }


    mutating func shuffle() {
        baby.shuffle()
        easy.shuffle()
        medium.shuffle()
        hard.shuffle()
        nightmare.shuffle()
    }
}
