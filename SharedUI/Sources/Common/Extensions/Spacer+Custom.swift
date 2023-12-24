//
//  SwiftUIView.swift
//
//
//  Created by Raul Batista on 17.12.2023.
//

import SwiftUI

public struct Spacer {
    let value: CGFloat?
}

extension Spacer: View {
    public var body: some View {
        if let value {
            SwiftUI.Spacer()
                .frame(
                    width: value,
                    height: value
                )
        } else {
            SwiftUI.Spacer()
        }
    }
}
