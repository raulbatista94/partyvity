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
            teamsCount: $viewModel.teamSize,
            didFinishEditign: { _ in },
            didTapAvatar: { eventHandler?.handle(event: .avatarTapped($0)) },
            nameChanged: { team, name in
                viewModel.updateTeam(team: team, name: name) }
        )
    }
}

struct TeamCreationView: View {
    @Binding var teams: [Team]
    @Binding var teamsCount: Int
    @State private var thumbImage: Image = .avatarGeek

    let didFinishEditign: (Team) -> Void
    let didTapAvatar: (Team) -> Void
    let nameChanged: (Team, String) -> Void
    var body: some View {
        VStack {
            ForEach(teams) { team in
                VStack(spacing: 10) {
                    TeamInputCellContainer(
                        viewModel: .init(team: team),
                        eventHandler: { cellEvent in
                            switch cellEvent {
                            case .avatarTapped(let team):
                                didTapAvatar(team)
                            case .finished(let team):
                                didFinishEditign(team)
                            case .nameChanged(let name):
                                nameChanged(team, name)
                            }
                        }
                    )
                }
            }

            Spacer(value: 150)

            Text("Amount of teams: \(teamsCount)")
                .font(.titleXLarge)
                .foregroundStyle(Color.white)

            TeamCreationSlider(
                value: $teamsCount,
                thumbImage: $thumbImage,
                trackColor: .textInputInactive,
                progressColor: .textInputActive
            )
        }
        .padding(.horizontal, 16)
        .modifier(WithBackgroundImage())
        .onChange(of: teamsCount) { teamSize in
            switch teamSize {
            case 1:
                thumbImage = .avatarGeek
            case 2:
                thumbImage = .avatarSmileNotSure
            case 3:
                thumbImage = .avatarCuteSmile
            case 4:
                thumbImage = .avatarSmile
            case 5:
                thumbImage = .avatarJapaneseSmile
            case 6:
                thumbImage = .avatarStarSmile
            default:
                print("❌ Invalid team size")
            }
        }
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
        teamsCount: .constant(2),
        didFinishEditign: { _ in },
        didTapAvatar: { _ in },
        nameChanged: { _, _ in }
    )
}
