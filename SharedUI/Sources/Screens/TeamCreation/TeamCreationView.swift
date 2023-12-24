//
//  TeamCreationView.swift
//  
//
//  Created by Raul Batista on 19.12.2023.
//

import Foundation
import SwiftUI
import Core

public struct TeamCreationViewContainer: View {
    @ObservedObject var viewModel: TeamCreationViewModel
    private weak var eventHandler: TeamCreationEventHandling?

    public init(viewModel: TeamCreationViewModel, eventHandler: TeamCreationEventHandling) {
        self.viewModel = viewModel
        self.eventHandler = eventHandler
    }

    public var body: some View {
        TeamCreationView(
            teams: $viewModel.teams,
            didFinishEditign: { viewModel.handleEditOfLastTeam() },
            didTapAvatar: { eventHandler?.handle(event: .avatarTapped($0)) }
        )
    }
}

struct TeamCreationView: View {
    @Binding var teams: [Team]
    let didFinishEditign: () -> Void
    let didTapAvatar: (Team) -> Void
    var body: some View {
        ForEach(teams) { team in
            VStack(spacing: 10) {
                TeamInputCellContainer(
                    viewModel: .init(team: team),
                    avatarTapped: { team in
                        didTapAvatar(team)
                    },
                    onFinishedEditing: didFinishEditign
                )
            }
            .padding(.horizontal, 16)
        }
        .modifier(WithBackgroundImage())
    }
}

#Preview {
    TeamCreationView(
        teams: .constant([
            Team(teamName: "Team 1"),
            Team(teamName: "Team 2", avatarId: R.image.avatarCash.name),
            Team(teamName: "Team 3"),
            Team(teamName: "Team 4")
        ]),
        didFinishEditign: {},
        didTapAvatar: { _ in }
    )
}
