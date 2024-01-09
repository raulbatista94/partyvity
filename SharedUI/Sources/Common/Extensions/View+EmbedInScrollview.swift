//
//  View+EmbedInScrollview.swift
//
//
//  Created by Raul Batista on 28.12.2023.
//

import SwiftUI

public extension View {
    func embedInScrollViewIfNeeded(axis: Axis.Set = .vertical, showsIndicators: Bool = false) -> some View {
        modifier(EmbedInScroll(showsIndicators: showsIndicators, axis: axis))
    }
}

private extension View {
    @ViewBuilder func embedInScrollView(when shouldEmbed: Bool, showsIndicators: Bool, axis: Axis.Set) -> some View {
        if shouldEmbed {
            ScrollView(axis, showsIndicators: showsIndicators) {
                self
            }
        } else {
            self
        }
    }
}

private struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

private struct EmbedInScroll: ViewModifier {
    let showsIndicators: Bool
    let axis: Axis.Set
    @State private var fitsInSuperview = false

    func body(content: Content) -> some View {
        GeometryReader { superviewGeometry in
            content
                .frame(width: superviewGeometry.size.width)
                .background(
                    GeometryReader { backgroundGeometry in
                        // Store background height in view preference
                        Color.clear.preference(
                            key: ContentHeightKey.self,
                            value: backgroundGeometry.frame(in: .local).size.height
                        )
                    }
                )
                .embedInScrollView(when: !fitsInSuperview, showsIndicators: showsIndicators, axis: axis)
                .onPreferenceChange(ContentHeightKey.self) { contentHeight in
                    fitsInSuperview = contentHeight <= superviewGeometry.size.height
                }
        }
    }
}
