//
//  AvatarSelectionView.swift
//
//
//  Created by Raul Batista on 26.12.2023.
//

import SwiftUI

public struct AvatarSelectionView: View {
    let columns = [
        GridItem(.adaptive(minimum: 72))
    ]

    let avatarSelected: (Avatar) -> Void
    let backAction: () -> Void

    public init(
        avatarSelected: @escaping (Avatar) -> Void,
        backAction: @escaping () -> Void
    ) {
        self.avatarSelected = avatarSelected
        self.backAction = backAction
    }

    public var body: some View {
        content()
            .modifier(WithBackgroundImage())
            .modifier(CustomNavBarModifier(
                title: "Select Avatar",
                action: backAction)
            )
    }

    @ViewBuilder
    func content() -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(Avatar.allCases, id: \.self) { avatar in
                    AvatarView(avatarImage: avatar.image)
                        .onTapGesture {
                            avatarSelected(avatar)
                        }
                }
            }
            .padding(.top, 100)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    AvatarSelectionView(
        avatarSelected: { _ in },
        backAction: {}
    )
}
