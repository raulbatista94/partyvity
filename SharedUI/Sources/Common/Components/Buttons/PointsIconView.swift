//
//  PointsIconView.swift
//
//
//  Created by Raul Batista on 07.12.2023.
//

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
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 48, height: 48)
            Text(type.title)
                .font(.titleMedium)
                .foregroundColor(type.foregroundColor)
                .shadow(color: .black, radius: 2)
                .rotationEffect(.degrees(type.rotationDegrees))
                
        }
        .background(Color.blue)
            
    }
}

#Preview {
    PointsIconView(type: .double)
}
