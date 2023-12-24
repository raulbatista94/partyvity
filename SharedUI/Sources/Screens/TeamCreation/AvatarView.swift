//
//  AvatarView.swift
//  
//
//  Created by Raul Batista on 22.12.2023.
//

import SwiftUI

struct AvatarView: View {
    let avatarImage: Image
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 23.0)
                .fill(Color.white)
                .shadow(radius: 2)
                .frame(width: 60, height: 60)

            avatarImage
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    AvatarView(avatarImage: .avatarAlien)
}
