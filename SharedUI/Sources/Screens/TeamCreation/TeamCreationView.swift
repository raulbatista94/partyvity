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
                    shouldShowStartButton: $viewModel.showStartButton,
                    didFinishEditign: { _ in },
                    didTapAvatar: { team in
                        eventHandler?.handle(
                            event: .avatarTapped { selectedAvatar in
                                viewModel.updateTeamsAvatar(
                                    team: team,
                                    avatar: selectedAvatar
                                )
                            }
                        )
                    },
                    nameChanged: { updatedTeam in
                        viewModel.updateTeam(team: updatedTeam, name: updatedTeam.teamName)
                    },
                    startTapped: {
                        eventHandler?.handle(event: .startGame)
                    }
                )
            }
        }
        .modifier(WithBackgroundImage())
    }
}

struct TeamCreationView: View {
    @Binding var teams: [Team]
    @Binding var teamsCount: Int
    @Binding var teamTableSize: CGFloat
    @Binding var shouldShowStartButton: Bool
    @State private var thumbImage: Image = .avatarGeek

    let didFinishEditign: (Team) -> Void
    let didTapAvatar: (Team) -> Void
    let nameChanged: (Team) -> Void
    let startTapped: () -> Void

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

            ZStack {
                Button(action: {
                    startTapped()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.carmineRed)
                            .frame(height: 48)

                        Text("Start")
                            .font(.headlineMedium)
                            .foregroundStyle(Color.white)
                    }
                })
                .padding(.horizontal, 16)
                .opacity(shouldShowStartButton ? 1 : 0)

                VStack {
                    Text("Number of teams: \(teamsCount)")
                        .font(.headlineSmall)
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
                .opacity(shouldShowStartButton ? 0 : 1)
            }
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
                viewModel: TeamInputCellViewModel(team: team),
                eventHandler: { cellEvent in
                    switch cellEvent {
                    case .avatarTapped(let team):
                        didTapAvatar(team)
                    case .finished(let team):
                        didFinishEditign(team)
                    case .teamNameUpdated(let team):
                        nameChanged(team)
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
        shouldShowStartButton: .constant(false),
        didFinishEditign: { _ in },
        didTapAvatar: { _ in },
        nameChanged: { _ in },
        startTapped: {  }
    )
}
