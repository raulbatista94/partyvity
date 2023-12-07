//
//  CustomButtonStyle.swift
//
//
//  Created by Raul Batista on 06.12.2023.
//

import SwiftUI

public struct CustomButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    let style: ComponentStyle
    let size: ComponentSize
    let icon: Icon?
    let onlyIcon: Bool
    let config: Config?

    init(
        style: ComponentStyle,
        size: ComponentSize,
        icon: Icon? = nil,
        onlyIcon: Bool = false,
        config: Config? = nil
    ) {
        self.style = style
        self.size = size
        self.icon = icon
        self.onlyIcon = onlyIcon
        self.config = config
    }

    public func makeBody(configuration: Configuration) -> some View {
        if onlyIcon {
            iconOnly(isPressed: configuration.isPressed)
        } else {
            buttonView(label: configuration.label, isPressed: configuration.isPressed)
        }
    }
}

private extension CustomButtonStyle {
    @ViewBuilder
    func iconOnly(isPressed: Bool) -> some View {
        if let icon {
            icon.image
                .renderingMode(.template)
                .foregroundColor(config?.foregroundColor)
                .frame(
                    width: config?.iconSize ?? 48,
                    height: config?.iconSize ?? 48
                )
                .foregroundStyle((config?.foregroundColor ?? .accentColor).opacity(isPressed ? 0.8 : 1.0))
        }
    }

    @ViewBuilder
    func buttonView(
        label: ButtonStyleConfiguration.Label,
        isPressed: Bool
    ) -> some View {
        HStack(spacing: 8) {
            if let icon, icon.position == .leading {
                iconImage(icon.image, isPressed: isPressed)
            }

            label
                .font(.headlineMedium)
                .foregroundStyle(foregroundColor.opacity(isPressed ? 0.8 : 1.0))
                .multilineTextAlignment(textAlignment)

            if let icon, icon.position == .trailing {
                iconImage(icon.image, isPressed: isPressed)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .frame(minHeight: 40)
        .background {
            buttonBackground(isPressed: isPressed)
        }
    }

    var textAlignment: TextAlignment {
        guard let icon else {
            return .center
        }

        return icon.position == .leading ? .leading : .trailing
    }

    func buttonBackground(isPressed: Bool) -> some View {
        RoundedRectangle(cornerRadius: config?.cornerRadius ?? 24)
            .fill(backgroundColor)
    }

    var foregroundColor: Color {
        let customColor = Color.white

        guard !isEnabled else {
            return customColor
        }

        let disabledCustomColor = customColor.opacity(0.8)
        switch style {
        case .primary:
            return disabledCustomColor
        case .secondary:
            return disabledCustomColor
        case .tertiary:
            return disabledCustomColor
        }
    }

    var backgroundColor: Color {
        switch style {
        case .primary:
            isEnabled ? .carmineRed : .gray
        case .secondary:
            .blueDark
        case .tertiary:
            .blueLight
        }
    }

    func iconImage(_ image: Image, isPressed: Bool) -> some View {
        image
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: config?.iconSize ?? 48,
                height: config?.iconSize ?? 48
            )
            .foregroundStyle(iconForegroundColor.opacity(isPressed ? 0.8 : 1.0))
    }

    var iconForegroundColor: Color {
        let customColor = config?.foregroundColor
        let customDisabledColor = customColor?.opacity(0.8)
        switch style {
        case .primary:
            return isEnabled ? customColor ?? .accentColor : customDisabledColor ?? .gray
        case .secondary, .tertiary:
            return isEnabled ? customColor ?? .blueDark : customDisabledColor ?? .gray
        }
    }
}

public extension CustomButtonStyle {
    struct Icon {
        let image: Image
        let position: ComponentPosition
    }

    struct Config {
        let backgroundColor: Color?
        let foregroundColor: Color?
        let iconSize: CGFloat?
        let cornerRadius: CGFloat

        init(
            backgroundColor: Color? = nil,
            foregroundColor: Color? = nil,
            iconSize: CGFloat? = nil,
            cornerRadius: CGFloat = 24
        ) {
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.iconSize = iconSize
            self.cornerRadius = cornerRadius
        }
    }
}
