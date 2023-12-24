//
//  SwiftUIView.swift
//  
//
//  Created by Raul Batista on 22.12.2023.
//

import SwiftUI
import Core
import Combine

@MainActor
final class TeamInputCellViewModel: ObservableObject {
    @Published var team: Team

    init(team: Team) {
        self.team = team
    }
}

struct TeamInputCellContainer: View {
    @ObservedObject var viewModel: TeamInputCellViewModel

    let avatarTapped: (Team) -> Void
    let onFinishedEditing: () -> Void
    var body: some View {
        TeamInputCell(
            avatar: viewModel.team.avatarId,
            teamName: $viewModel.team.teamName,
            avatarTapped: {
                avatarTapped(viewModel.team)
            }, 
            finishedEditing: {
                onFinishedEditing()
            }
        )
    }
}

struct TeamInputCell: View {
    var avatar: String?
    @Binding var teamName: String
    let avatarTapped: () -> Void
    let finishedEditing: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(avatarImage: Image(
                avatar ?? R.image.defaultAvatar.name,
                bundle: Bundle.module)
            )
            .onTapGesture {
                avatarTapped()
            }

            InputFieldViewContainer(
                text: $teamName,
                didFinishEditing: finishedEditing
            )
            .padding(.vertical, 2)
        }
        .frame(height: 64)
    }
}

#Preview {
    TeamInputCell(
        avatar: R.image.avatarWink.name,
        teamName: .constant("The best ones"),
        avatarTapped: { }, 
        finishedEditing: { }
    )
}
