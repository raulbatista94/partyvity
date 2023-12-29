//
//  Sequence+Async.swift
//  
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation

public extension Sequence {
    func asyncForEach(
        _ operation: @Sendable (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }

    func asyncMap<Value>(
        _ transform: @Sendable (Element) async throws -> Value
    ) async rethrows -> [Value] {
        var values = [Value]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }

    func asyncReduce<Value>(
        into initialResult: Value,
        _ updateAccumulatingResult: @escaping @Sendable (inout Value, Element) async throws -> Void
    ) async rethrows -> Value {
        var result = initialResult
        for element in self {
            try await updateAccumulatingResult(&result, element)
        }
        return result
    }
}
