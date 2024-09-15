//
//  RoundResultView.swift
//  
//
//  Created by Raul Batista on 15.09.2024.
//

import SwiftUI

struct RoundResultView: View {
    @Binding var earnedPoints: Int

    var body: some View {
        VStack {
            Text("Good Job!")
                .font(.titleXLarge)
                .foregroundStyle(.white)

            Text("You earned \(earnedPoints) points!")
                .font(.bodyMedium)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    RoundResultView(earnedPoints: .constant(20))
}
