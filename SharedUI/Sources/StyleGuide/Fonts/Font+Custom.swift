//
//  File.swift
//  
//
//  Created by Raul Batista on 06.12.2023.
//

import SwiftUI
import RswiftResources

public extension Font {
    static let titleXXLarge = makeFont(name: R.font.nunitoBlack.name, size: 48, relativeTo: .largeTitle)
    static let titleXLarge = makeFont(name: R.font.nunitoExtraBold.name, size: 40, relativeTo: .title)
    static let titleMedium = makeFont(name: R.font.nunitoExtraBold.name, size: 26, relativeTo: .title2)
    static let headlineMedium = makeFont(name: R.font.nunitoBold.name, size: 30, relativeTo: .headline)
    static let bodyLarge = makeFont(name: R.font.nunitoSemiBold.name, size: 36, relativeTo: .body)
    static let bodyMedium = makeFont(name: R.font.nunitoSemiBold.name, size: 32, relativeTo: .body)
    static let bodySmall = makeFont(name: R.font.nunitoSemiBold.name, size: 22, relativeTo: .body)
}

private extension Font {
    static func makeFont(name: String, size: CGFloat, relativeTo: TextStyle) -> Font {
        .custom(name, size: size, relativeTo: relativeTo)
    }
}
