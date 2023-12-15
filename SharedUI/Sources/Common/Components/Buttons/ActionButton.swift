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
    let style: ComponentStyle
    let size: ComponentSize
    let icon: Image?

    init(
        onTap: @escaping () -> Void,
        title: String,
        style: ComponentStyle,
        size: ComponentSize = .medium,
        icon: Image? = nil
    ) {
        self.onTap = onTap
        self.title = title
        self.style = style
        self.size = size
        self.icon = icon
    }

    var body: some View {
        Button(
            action: onTap,
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(backgroundColor)

                    Text(title)
                        .font(font)
                        .foregroundStyle(.white)
                }
            }
        )
    }
}

private extension ActionButton {
    var backgroundColor: Color {
        switch style {
        case .primary:
            .carmineRed
        case .secondary:
            .blueDark
        case .tertiary:
            .blueLight
        }
    }

    var font: Font {
        switch size {
        case .xlarge:
            .titleXXLarge
        case .large:
            .titleXLarge
        case .medium:
            .headlineMedium
        case .small:
            .bodyMedium
        }
    }
}

#Preview {
    ActionButton(
        onTap: {},
        title: "Main Menu",
        style: .primary, 
        size: .medium
    )
}
