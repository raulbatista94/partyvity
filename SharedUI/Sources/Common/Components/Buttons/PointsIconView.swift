//
//  PointsIconView.swift
//
//
//  Created by Raul Batista on 07.12.2023.
//

import Core
import SwiftUI

struct PointsIconView: View {
    enum PointsType {
        case normal
        case double
        case tripe

        var title: String {
            switch self {
            case .normal:
                return "1x"
            case .double:
                return "2x"
            case .tripe:
                return "3x"
            }
        }

        var foregroundColor: Color {
            switch self {
            case .normal:
                    .singlePoints
            case .double:
                    .doublePoints
            case .tripe:
                    .triplePoints
            }
        }

        var rotationDegrees: Double {
            switch self {
            case .normal:
                -5
            case .double:
                20
            case .tripe:
                -15
            }
        }
    }

    let type: PointsType

    var body: some View {
        Text(type.title)
            .font(.titleMedium)
            .foregroundColor(type.foregroundColor)
            .rotationEffect(.degrees(type.rotationDegrees))
            .shadow(
                color: .buttonNumberShadow,
                radius: 0.5
            )
            .shadow(
                color: .buttonNumberShadow,
                radius: 0.5
            )
            .shadow(
                color: .buttonNumberShadow,
                radius: 0.5
            )
            .padding(.all, 10)
            .background(
                Circle()
                    .fill(Color.white)
            )
            .shadow(
                color: .black.opacity(0.3),
                radius: 5,
                x: 0,
                y: 2
            )
    }
}

extension PointsIconView {
    static func makeForActivity(_ activityType: ActivityType) -> Self {
        switch activityType {
        case .describe:
            return .init(type: .normal)
        case .drawing:
            return .init(type: .double)
        case .pantomime:
            return .init(type: .tripe)
        }
    }
}

#Preview {
    PointsIconView(type: .double)
}
