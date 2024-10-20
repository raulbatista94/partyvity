//
//  SwiftUIView.swift
//
//
//  Created by Raul Batista on 09.03.2024.
//

import Core
import SwiftUI

struct ProgressView: View {
    let gameMaxPoints: Int

    @Binding var teams: [Team]
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
                ForEach(0..<teams.count, id: \.self) { teamIndex in
                    progressBar(
                        proxy: proxy,
                        progressBarColor: colors[teamIndex],
                        progress: Double(teams[teamIndex].score) / CGFloat(gameMaxPoints)
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
        progressBarColor: Color,
        progress: Double
    ) -> some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(
                    width: (proxy.size.width * progress) + 4,
                    height: 12
                )
                .offset(x: -4)
                .foregroundStyle(progressBarColor)
                .animation(.easeInOut, value: progress)

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
    ProgressView(
        gameMaxPoints: 60,
        teams: .constant([
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
    )
}
