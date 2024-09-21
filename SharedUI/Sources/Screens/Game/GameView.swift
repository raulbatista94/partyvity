//
//  GameView.swift
//
//
//  Created by Raul Batista on 25.02.2024.
//

import Core
import SwiftUI

public struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    public init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        GeometryReader { reader in
            VStack {
                headerView(reader: reader)

                SwiftUI.Spacer(minLength: 44).layoutPriority(1)
                ZStack(alignment: .center) {
                    getGamePhaseView()
                        .frame(maxHeight: reader.size.height * 0.48)
                }

                SwiftUI.Spacer().layoutPriority(1)

            }
            .safeAreaInset(edge: .bottom, content: {
                getGameFooterView()
            })
        }
        .onAppear {
            viewModel.send(input: .viewDidAppear)
        }
        .modifier(WithBackgroundImage())
    }
}

// MARK: - Subviews
private extension GameView {
    @ViewBuilder
    func headerView(reader: GeometryProxy) -> some View {
        ZStack {
            HeaderBackground(
                topColor: .init(
                    get: {
                        viewModel.currentTeamColor.lighten(by: 0.3)
                    },
                    set: { _ in }
                ),
                bottomColor: .init(
                    get: {
                        viewModel.currentTeamColor.darken(by: 0.3)
                    },
                    set: { _ in }
                )
            )
            .animation(.bouncy, value: viewModel.currentTeamColor)
            .frame(height: reader.size.height * 0.26)

            HStack(spacing: 24) {
                AvatarView(avatarImage: (Avatar(rawValue: viewModel.currentTurnTeam.avatarId ?? Avatar.avatarAlien.rawValue) ?? .avatarAlien).image)

                Text(viewModel.currentTurnTeam.teamName)
                    .font(.bodyLarge)
                    .foregroundStyle(Color.white)

                SwiftUI.Spacer()
            }
            .padding([.bottom, .leading])
        }
    }

    @ViewBuilder
    func getGamePhaseView() -> some View {
        switch viewModel.gamePhase {
        case .activityPicking:
            GameActivityPickingView { selectedActivity in
                viewModel.send(input: .didTapActivity(selectedActivity))
            }
            .padding(.horizontal, 56)
        case .guessing:
            VStack(spacing: .zero) {
                Text("\(viewModel.remainingTime)s")
                    .font(.headlineMedium)
                    .foregroundStyle(.white)
                    .padding(.bottom)

                Rectangle()
                    .fill(.white.opacity(0.25))
                    .frame(height: 1)
                    .shadow(radius: 3, y: 5)
                    .padding(.horizontal, 42)

                GameGuessingView(
                    word: .init(
                        get: { viewModel.currentWord ?? "" },
                        set: { _ in }
                    ),
                    teamColor: .init(
                        get: { viewModel.currentTeamColor },
                        set: { _ in }
                    ),
                    wordDidAppear: {
                        viewModel.send(input: .wordDidAppear)
                    }
                )
                .clipped()
            }
        case .roundEvaluation:
            RoundResultView(earnedPoints: $viewModel.earnedPointsThisTurn)
                .onTapGesture {
                    viewModel.send(input: .didFinishRound)
                }
        }
    }

    @ViewBuilder
    func getGameFooterView() -> some View {
        switch viewModel.gamePhase {
        case .activityPicking, .roundEvaluation:
            ProgressView(teams: viewModel.teams)
                .frame(maxHeight: 120)
        case .guessing:
            ActionButton(
                onTap: {
                    viewModel.send(input: .advanceToNextWord)
                },
                title: "Got it!",
                style: .tertiary,
                backgroundColor: .init(
                    get: { viewModel.currentTeamColor },
                    set: { _ in }
                )
            )
            .frame(height: 64)
            .padding(.horizontal, 16)
            .padding(.bottom)
        }
    }
}

#Preview {
    GameView(
        viewModel: GameViewModel(
            teams: GameViewModel.mockTeams,
            wordService: WordService.mock
        )
    )
}
