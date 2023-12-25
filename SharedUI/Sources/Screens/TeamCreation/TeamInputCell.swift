//
//  TeamInputCellViewModel.swift
//  
//
//  Created by Raul Batista on 22.12.2023.
//

import SwiftUI
import Core

@MainActor
final class TeamInputCellViewModel: ObservableObject {
    @Published var team: Team
    @Published var teamName: String

    init(team: Team) {
        self.team = team
        self.teamName = team.teamName
    }
}

struct TeamInputCellContainer: View {
    enum TeamCellEvent {
        case avatarTapped(Team)
        case nameChanged(String)
        case finished(Team)
    }
    @ObservedObject var viewModel: TeamInputCellViewModel
    let eventHandler: (TeamCellEvent) -> Void
    var body: some View {
        TeamInputCell(
            avatar: viewModel.team.avatarId,
            teamName: $viewModel.teamName,
            avatarTapped: {
                eventHandler(.avatarTapped(viewModel.team))
            },
            finishedEditing: {
                eventHandler(.finished(viewModel.team))
            }
        )
        .onChange(of: viewModel.teamName) { name in
            eventHandler(.nameChanged(name))
        }
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
