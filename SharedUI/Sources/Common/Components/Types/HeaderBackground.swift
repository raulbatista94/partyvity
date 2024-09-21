//
//  HeaderBackground.swift
//
//
//  Created by Raul Batista on 28.12.2023.
//

import SwiftUI

struct HeaderBackground: View {
    @Binding var topColor: Color
    @Binding var bottomColor: Color

    init(
        topColor: Binding<Color> = .constant(.gradientPurpleLight),
        bottomColor: Binding<Color> = .constant(.gradientPurpleDark)
    ) {
        self._topColor = topColor
        self._bottomColor = bottomColor
    }

    var body: some View {
        HeaderBackgroundShape()
            .fill(
                LinearGradient(
                    colors: [topColor, bottomColor],
                    startPoint: .top,
                    endPoint: .bottom)
            )
            .shadow(color: .black, radius: 20, x: 0, y: 10)
            .ignoresSafeArea(edges: .top)
    }
}
