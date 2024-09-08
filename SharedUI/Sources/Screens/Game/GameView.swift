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

    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        GeometryReader { reader in
            VStack {
                headerView(reader: reader)

                SwiftUI.Spacer().layoutPriority(1)

                getGamePhaseView()
                    .padding(.horizontal, 56)

                SwiftUI.Spacer().layoutPriority(1)

                ProgressView(teams: viewModel.teams)
                    .padding(.bottom, 40)
            }
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
        case .guessing:
            GameGuessingView()
                .clipped()
        case .gameResolving:
            Text("VOL")
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel(teams: GameViewModel.mockTeams))
}
