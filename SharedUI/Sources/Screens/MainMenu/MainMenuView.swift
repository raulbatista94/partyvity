//
//  InitialView.swift
//  
//
//  Created by Raul Batista on 13.12.2023.
//

import SwiftUI

public struct MainMenuContainerView: View {
    @StateObject private var viewModel: MainMenuViewModel
    public var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            MainMenuView(
                newGameAction: { viewModel.handleEvent(.newGameButtonTapped) },
                continueGameAction: { viewModel.handleEvent(.continueButtonTapped) },
                previousGamesAction: { viewModel.handleEvent(.previousGamesButtonTapped) },
                shouldShowContinueGameButton: viewModel.gameInProgressAvailable
            )
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
    }

    public init(viewModel: MainMenuViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}

struct MainMenuView: View {
    let newGameAction: () -> Void
    let continueGameAction: () -> Void
    let previousGamesAction: () -> Void
    let shouldShowContinueGameButton: Bool

    var body: some View {
        VStack {
            LogoView()

            Spacer(value: 56)

            ActionButton(
                onTap: {
                    newGameAction()
                },
                title: AppStrings.newGame,
                style: .primary
            )
            .frame(height: 64)

            if shouldShowContinueGameButton {
                ActionButton(
                    onTap: {
                        continueGameAction()
                    },
                    title: AppStrings.continue,
                    style: .secondary
                )
                .frame(height: 64)
            }

            ActionButton(
                onTap: {
                    previousGamesAction()
                },
                title: AppStrings.previousGames,
                style: .tertiary
            )
            .frame(height: 64)
        }
    }
}

#Preview {
    MainMenuView(
        newGameAction: {},
        continueGameAction: {},
        previousGamesAction: {},
        shouldShowContinueGameButton: false
    )
    .padding(.horizontal, 16)
}
