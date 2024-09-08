//
//  GameActivityPickingView.swift
//
//
//  Created by Raul Batista on 08.09.2024.
//

import Core
import SwiftUI

struct GameActivityPickingView: View {
    let action: (ActivityType) -> Void
    var body: some View {
        VStack(spacing: 16) {
            ForEach(ActivityType.allCases, id: \.self) { activity in
                ActionButton(
                    onTap: {
                        action(activity)
                    },
                    title: activity.buttonTitle,
                    style: setComponentStyle(for: activity),
                    pointsIcon: .makeForActivity(activity)
                )
            }
        }
    }
}

private extension GameActivityPickingView {
    func setComponentStyle(for activity: ActivityType) -> ComponentStyle {
        switch activity {
        case .describe:
            return .primary
        case .drawing:
            return .secondary
        case .pantomime:
            return .tertiary
        }
    }
}

#Preview {
    GameActivityPickingView { _ in

    }
}
