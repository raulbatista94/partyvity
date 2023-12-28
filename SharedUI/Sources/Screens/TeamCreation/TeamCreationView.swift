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
        ZStack(alignment: .top) {
            HeaderBackground()
                .frame(height: viewModel.teamTableSize)

            VStack {
                BackNavigationBarView(
                    title: "Teams",
                    action: {
                        eventHandler?.handle(event: .back)
                    }
                )

                TeamCreationView(
                    teams: $viewModel.teams,
                    teamsCount: $viewModel.teamSize,
                    teamTableSize: $viewModel.teamTableSize,
                    didFinishEditign: { _ in },
                    didTapAvatar: { eventHandler?.handle(event: .avatarTapped($0)) }
                )
            }
        }
        .modifier(WithBackgroundImage())
    }
}

struct TeamCreationView: View {
    @Binding var teams: [Team]
    @Binding var teamsCount: Int
    @State private var thumbImage: Image = .avatarGeek
    @Binding var teamTableSize: CGFloat
    let didFinishEditign: (Team) -> Void
    let didTapAvatar: (Team) -> Void

    var body: some View {
        VStack {
            VStack {
                createTeamsView()
            }
            .readSize { newSize in
                print("New height is \(newSize.height)")
                teamTableSize = newSize.height + 64 + 38 // + cell height + spacing under the last item
            }
            .padding(.horizontal, 16)

            SwiftUI.Spacer()

            Text("Amount of teams: \(teamsCount)")
                .font(.headlineMedium)
                .foregroundStyle(Color.white)

            TeamCreationSlider(
                value: $teamsCount,
                thumbImage: $thumbImage,
                trackColor: .textInputInactive,
                progressColor: .textInputActive
            )
            .frame(height: 80)
            .padding(.horizontal, 16)
        }
        .embedInScrollViewIfNeeded(
            axis: .vertical,
            showsIndicators: false
        )
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

private extension TeamCreationView {
    @MainActor
    func createTeamsView() -> some View {
        ForEach(teams) { team in
            TeamInputCellContainer(
                viewModel: .init(team: team),
                eventHandler: { cellEvent in
                    switch cellEvent {
                    case .avatarTapped(let team):
                        didTapAvatar(team)
                    case .finished(let team):
                        didFinishEditign(team)
                    }
                }
            )
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
        teamTableSize: .constant(100),
        didFinishEditign: { _ in },
        didTapAvatar: { _ in }
    )
}
