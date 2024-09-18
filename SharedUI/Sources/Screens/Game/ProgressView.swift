//
//  SwiftUIView.swift
//  
//
//  Created by Raul Batista on 09.03.2024.
//

import Core
import SwiftUI

struct ProgressViewContainer: View {
    var body: some View {
        ProgressView(teams: [

        ])
    }
}

struct ProgressView: View {
    var teams: [Team]
    private let colors = [
        Color.blueLight,
        Color.carmineRed,
        Color.teamOrange,
        Color.teamPurple,
        Color.yellowBorder,
        Color.textInputActive
    ]

    var body: some View {
        GeometryReader { proxy in
            VStack {
                ForEach(teams.indices) { teamIndex in
                    progressBar(
                        proxy: proxy,
                        progressBarColor: colors[teamIndex]
                    )
                }
            }
        }
    }
}

private extension ProgressView {
    @ViewBuilder
    func progressBar(
        proxy: GeometryProxy,
        progressBarColor: Color
    ) -> some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(
                    width: proxy.size.width * 0.9,
                    height: 12
                )
                .foregroundStyle(progressBarColor)

            Rectangle()
                .frame(
                    width: proxy.size.width,
                    height: 4
                )
                .foregroundStyle(Color.white.opacity(0.1))
        }
    }
}

#Preview {
    ProgressView(teams: [
        Team(
            id: UUID().uuidString,
            teamName: "Klokani",
            avatarId: Avatar.avatarAlert.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Klokanice",
            avatarId: Avatar.avatarCash.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Klokanice",
            avatarId: Avatar.avatarCash.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Klokanice",
            avatarId: Avatar.avatarCash.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Klokanice",
            avatarId: Avatar.avatarCash.rawValue
        ),
        Team(
            id: UUID().uuidString,
            teamName: "Klokanice",
            avatarId: Avatar.avatarCash.rawValue
        )
    ])
}
