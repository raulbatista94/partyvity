//
//  File.swift
//  
//
//  Created by Raul Batista on 21.09.2024.
//

import SwiftUI
import UIKit

extension Color {

    // Lightens the color by a given percentage
    func lighten(by percentage: CGFloat) -> Color {
        return self.adjustBrightness(by: abs(percentage))
    }

    // Darkens the color by a given percentage
    func darken(by percentage: CGFloat) -> Color {
        return self.adjustBrightness(by: -abs(percentage))
    }

    // Adjusts brightness (positive to lighten, negative to darken)
    private func adjustBrightness(by percentage: CGFloat) -> Color {
        // Convert SwiftUI Color to UIColor (iOS)
        var uic: UIColor?

        // Work with color components
        if #available(iOS 14.0, *) {
            let uiColor = UIColor(self)
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0

            if uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
                let newBrightness = min(max(brightness + percentage, 0), 1)
                uic = UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
            }
        }

        // Convert back to SwiftUI Color
        if let uic = uic {
            return Color(uic)
        }

        // Return self in case of failure
        return self
    }
}
