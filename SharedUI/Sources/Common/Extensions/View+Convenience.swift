//
//  View+Convenience.swift
//  
//
//  Created by Raul Batista on 15.12.2023.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        _ transform: (Self) -> Content,
        else: ((Self) -> Content)? = nil
    ) -> some View {
        if condition {
            transform(self)
        } else {
            if let `else` {
                `else`(self)
            } else {
                self
            }
        }
    }

    @ViewBuilder
    func `if`<Wrapped>(
        _ wrapped: Wrapped?,
        _ transform: @escaping (Self, Wrapped) -> some View
    ) -> some View {
        switch wrapped {
        case .none:
            self
        case let .some(unwrapped):
            transform(self, unwrapped)
        }
    }
}
