//
//  SwiftUIView.swift
//  
//
//  Created by Raul Batista on 06.12.2023.
//

import SwiftUI

struct ActionButton: View {
    private let onTap: () -> Void
    private let title: String
    private let style: CustomButtonStyle

    init(
        onTap: @escaping () -> Void,
        title: String,
        style: CustomButtonStyle
    ) {
        self.onTap = onTap
        self.title = title
        self.style = style
    }

    var body: some View {
        Button(
            action: onTap,
            label: {
                Text(title)
            }
        )
        .buttonStyle(style)
        .frame(height: 64)
    }
}

#Preview {
    ActionButton(
        onTap: {},
        title: "Main Menu",
        style: CustomButtonStyle(
            style: .primary,
            size: .large
        )
    )
}
