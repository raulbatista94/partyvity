//
//  WordService.swift
//
//
//  Created by Raul Batista on 15.09.2024.
//

import Foundation

public protocol WordProviding {
    /// From the loaded database of words, returns random word for selected difficulty.
    /// - Parameter difficulty: Currently selected word difficulty
    /// - Returns: Random word for selected difficulty
    func randomWord(for difficulty: WordDifficulty) -> String
}

public final class WordService: WordProviding {
    private lazy var wordDatabase: WordDatabase? = nil
    private lazy var backupWordsDatabase: WordDatabase? = nil // used in case that for some difficulty we consume all the words

    public init() {
        loadWordDatabase()
    }

    private func loadWordDatabase() {
        guard let path = Bundle.module.path(forResource: "words", ofType: "json") else {
            fatalError("Coudln't load words.json file!")
        }

        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Coudln't read words.json file!")
        }

        guard let wordDatabase = try? JSONDecoder().decode(WordDatabase.self, from: data) else {
            fatalError("Coudln't parse words.json file!")
        }

        for difficulty in WordDifficulty.allCases {
            if wordDatabase[difficulty].isEmpty {
                fatalError("Word database for difficulty: \(difficulty.rawValue) is empty or missing!")
            }
        }

        self.backupWordsDatabase = wordDatabase
        self.wordDatabase = wordDatabase
    }

    public func randomWord(for difficulty: WordDifficulty) -> String {
        if wordDatabase?[difficulty].isEmpty == true {
            wordDatabase?[difficulty] = backupWordsDatabase?[difficulty].shuffled() ?? []
        }

        guard let randomlySelectedWord = wordDatabase?[difficulty].removeLast() else {
            assertionFailure("This should never happen since we re-fill the words in case that we run out of them")
            return "- - -"
        }
        
        return randomlySelectedWord
    }
}

public extension WordService {
    static let mock = WordService()
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let currentCount = count
        guard currentCount > 1 else { return }

        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: currentCount, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let distance: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let swapIndex = index(firstUnshuffled, offsetBy: distance)
            swapAt(firstUnshuffled, swapIndex)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

