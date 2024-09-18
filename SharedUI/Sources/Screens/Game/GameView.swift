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

                SwiftUI.Spacer().layoutPriority(1)

                if viewModel.gamePhase == .guessing {
                    Text("\(viewModel.remainingTime)s")
                        .font(.headlineMedium)
                        .foregroundStyle(.white)
                }

                getGamePhaseView()
                    .frame(maxHeight: reader.size.height * 0.48)

                SwiftUI.Spacer().layoutPriority(1)

                getGameFooterView()
            }
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
            HeaderBackground()
                .frame(height: reader.size.height * 0.26)

            HStack(spacing: 24) {
                AvatarView(avatarImage: .avatarAlien)

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
                    wordDidAppear: {
                        viewModel.send(input: .wordDidAppear)
                    }
                )
                .clipped()
            }
        case .roundEvaluation:
            RoundResultView(earnedPoints: $viewModel.earnedPointsThisTurn)
        }
    }

    @ViewBuilder
    func getGameFooterView() -> some View {
        switch viewModel.gamePhase {
        case .activityPicking, .roundEvaluation:
            ProgressView(teams: viewModel.teams)
                .padding(.bottom, 40)
        case .guessing:
            ActionButton(
                onTap: {
                    viewModel.send(input: .advanceToNextWord)
                },
                title: "Got it!",
                style: .tertiary
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
            wordService: WordService.mock)
    )
}
