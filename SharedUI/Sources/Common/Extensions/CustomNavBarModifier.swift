//
//  CustomNavBarModifier.swift
//
//
//  Created by Raul Batista on 28.12.2023.
//

import Foundation
import SwiftUI

struct CustomNavBarModifier: ViewModifier {
    let title: String
    let action: () -> Void
    let height: CGFloat

    init(title: String, action: @escaping () -> Void, height: CGFloat = 80) {
        self.title = title
        self.action = action
        self.height = height
    }
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            CustomNavigationBar(title: title, action: action)
                .frame(height: height)
        }
    }
}
