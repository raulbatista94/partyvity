//
//  SwiftUIView.swift
//
//
//  Created by Raul Batista on 27.12.2023.
//

import SwiftUI

struct CustomNavigationBar: View {
    private let title: String
    private let action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        ZStack {
            HeaderBackground()

            BackNavigationBarView(
                title: title,
                action: action
            )
        }
    }
}

#Preview {
    CustomNavigationBar(title: "Teams", action: {})
        .frame(height: 104)
}
