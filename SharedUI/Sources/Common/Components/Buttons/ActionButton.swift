//
//  ActionButton.swift
//
//
//  Created by Raul Batista on 06.12.2023.
//

import SwiftUI

struct ActionButton: View {
    private let onTap: () -> Void
    private let title: String
    private let style: ComponentStyle
    private let size: ComponentSize
    private let icon: Image?
    private let pointsIcon: PointsIconView?
    private let backgroundColor: Binding<Color?>

    init(
        onTap: @escaping () -> Void,
        title: String,
        style: ComponentStyle,
        size: ComponentSize = .medium,
        icon: Image? = nil,
        pointsIcon: PointsIconView? = nil,
        backgroundColor: Binding<Color?> = .constant(nil)
    ) {
        self.onTap = onTap
        self.title = title
        self.style = style
        self.size = size
        self.icon = icon
        self.pointsIcon = pointsIcon
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        Button(
            action: onTap,
            label: {
                Text(title)
                    .font(font)
                    .foregroundStyle(.white)
                    .if(pointsIcon != nil) { view in
                        HStack {
                            pointsIcon!
                            
                            view
                            
                            SwiftUI.Spacer()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(backgroundColor.wrappedValue ?? styleBackgroundColor)
                    )
            }
        )
    }
}

private extension ActionButton {
    var styleBackgroundColor: Color {
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
        size: .medium,
        pointsIcon: PointsIconView(type: .tripe)
    )
}
