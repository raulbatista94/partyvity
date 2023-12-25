//
//  BackgroundViewModifier.swift
//
//
//  Created by Raul Batista on 25.12.2023.
//

import SwiftUI

struct WithBackgroundImage: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            content
        }
    }
}
