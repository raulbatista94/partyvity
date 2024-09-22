//
//  TeamCreationView.swift
//
//
//  Created by Raul Batista on 19.12.2023.
//

import Core
import Combine
import Foundation
import SwiftUI

public struct TeamCreationViewContainer: View {
    @ObservedObject var viewModel: TeamCreationViewModel

    public init(viewModel: TeamCreationViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack(alignment: .top) {
            HeaderBackground()
                .frame(height: viewModel.teamTableSize)
                .animation(.easeInOut, value: 0.1)

            VStack {
                BackNavigationBarView(
                    title: "Teams",
                    action: {
                        viewModel.send(.back)
                    }
                )

                TeamCreationView(
                    teams: $viewModel.teams,
                    teamsCount: $viewModel.teamSize,
                    teamTableSize: $viewModel.teamTableSize,
                    shouldShowStartButton: $viewModel.showStartButton,
                    didFinishEditign: { _ in },
                    didTapAvatar: { team in
                        viewModel.send(.avatarTapped(team))
                    },
                    nameChanged: { updatedTeam in
                        viewModel.send(.updateTeamName(updatedTeam))
                    },
                    startTapped: {
                        viewModel.send(.startGame)
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
                teamTableSize = newSize.height + 64 + 38 // + cell height + spacing under the last item
            }
            .padding(.horizontal, 16)

            SwiftUI.Spacer()

            ZStack {
                ActionButton(
                    onTap: { startTapped() },
                    title: "Start",
                    style: .primary
                )
                .padding(.horizontal, 16)
                .opacity(shouldShowStartButton ? 1 : 0)

                VStack {
                    Text("Number of teams: \(teamsCount)")
                        .font(.headlineSmall)
                        .foregroundStyle(Color.white)

                    HStack(spacing: 10) {
                        Button(action: {
                            teamsCount = min(teamsCount + 1, 6)
                        }, label: {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .overlay(content: {
                                    Text("+")
                                        .font(.titleXXLarge)
                                        .foregroundStyle(.white)
                                        .padding(.bottom, 8)
                                })
                        })
                        .frame(size: 64)

                        thumbImage
                            .resizable()
                            .animation(.linear, value: thumbImage)
                            .frame(size: 64)

                        Button(action: {
                            teamsCount = max(teamsCount - 1, 1)
                        }, label: {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .overlay(content: {
                                    Text("-")
                                        .font(.titleXXLarge)
                                        .foregroundStyle(.white)
                                        .padding(.bottom, 8)
                                })
                        })
                        .frame(size: 64)
                    }

//                    TeamCreationSlider(
//                        value: $teamsCount,
//                        thumbImage: $thumbImage,
//                        trackColor: .textInputInactive,
//                        progressColor: .textInputActive
//                    )
//                    .frame(height: 80)
//                    .padding(.horizontal, 16)
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
