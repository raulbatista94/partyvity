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
                newGameAction: { viewModel.send(event: .newGameButtonTapped) },
                continueGameAction: { viewModel.send(event: .continueButtonTapped) },
                previousGamesAction: { viewModel.send(event: .previousGamesButtonTapped) },
                shouldShowContinueGameButton: viewModel.gameInProgressAvailable
            )
            .padding(.horizontal, 16)
        }
        .onAppear {
            viewModel.send(event: .viewDidAppear)
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

            if shouldShowContinueGameButton {
                ActionButton(
                    onTap: {
                        continueGameAction()
                    },
                    title: AppStrings.continue,
                    style: .secondary
                )
            }

            ActionButton(
                onTap: {
                    previousGamesAction()
                },
                title: AppStrings.previousGames,
                style: .tertiary
            )
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
