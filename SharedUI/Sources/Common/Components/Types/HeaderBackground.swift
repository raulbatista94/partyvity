//
//  HeaderBackground.swift
//
//
//  Created by Raul Batista on 28.12.2023.
//

import SwiftUI

struct HeaderBackground: View {
    var body: some View {
        HeaderBackgroundShape()
            .fill(
                LinearGradient(
                    colors: [.gradientPurpleLight, .gradientPurpleDark],
                    startPoint: .top,
                    endPoint: .bottom)
            )
            .shadow(color: .black, radius: 20, x: 0, y: 10)
            .ignoresSafeArea(edges: .top)
    }
}
