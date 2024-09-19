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

                if viewModel.gamePhase == .guessing {
                    Text("\(viewModel.remainingTime)s")
                        .font(.headlineMedium)
                        .foregroundStyle(.white)
                }
                ZStack(alignment: .center) {
                    if viewModel.gamePhase == .guessing {
                        circularProgressView(progress: Double(viewModel.remainingTime) / 60, proxy: reader)
                            .offset(y: -62)
                    }
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
            HeaderBackground()
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
                style: .tertiary
            )
            .frame(height: 64)
            .padding(.horizontal, 16)
            .padding(.bottom)
        }
    }

    func circularProgressView(progress: Double, proxy: GeometryProxy) -> some View {
        ZStack {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    viewModel.currentTeamColor,
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .round,
                        lineJoin: .round)
                )

            Circle()
                .trim(from: progress, to: 4)
                .stroke(Color.gradientPurpleLight.opacity(0.32), lineWidth: 2)
        }
        .frame(width: proxy.size.height * 0.48, height: proxy.size.height * 0.48)
        .rotationEffect(.degrees(-90))
        .animation(.easeInOut, value: progress)
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
