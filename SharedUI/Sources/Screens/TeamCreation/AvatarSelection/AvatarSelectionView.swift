//
//  AvatarSelectionView.swift
//
//
//  Created by Raul Batista on 26.12.2023.
//

import SwiftUI

public struct AvatarSelectionViewContainer: View {
    public var body: some View {
        AvatarSelectionView()
    }
}

struct AvatarSelectionView: View {
    let columns = [
        GridItem(.adaptive(minimum: 72, maximum: 88))
    ]
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(Avatar.allCases, id: \.self) { avatar in
                    AvatarView(avatarImage: avatar.image)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    AvatarSelectionView()
}
