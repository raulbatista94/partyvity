//
//  GameGuessingView.swift
//
//
//  Created by Raul Batista on 08.09.2024.
//

import SwiftUI

struct GameGuessingView: View {
    @State var offset: CGFloat = -48
    @Binding var word: String
    let wordDidAppear: () -> Void

    var body: some View {
        wordView
            .offset(y: offset)
    }
}

extension GameGuessingView {
    var wordView: some View {
        ZStack(alignment: .center) {
            Image(.word)

            Text(word)
                .font(.headlineMedium)
                .foregroundStyle(Color.textPrimary)
                .padding(.bottom, 20)
        }
        .offset(y: offset)
        .gesture(
            DragGesture(coordinateSpace: .global)
                .onChanged { gesture in
                    withAnimation {
                        guard
                            gesture.translation.height > .zero,
                            gesture.translation.height < 40
                        else {
                            return
                        }

                        self.offset = gesture.translation.height - 48

                        if offset > -20 {
                            wordDidAppear()
                        }
                    }
                }
                .onEnded { gesture in
                    self.offset = -48
                }
        )
    }
}

#Preview {
    GameGuessingView(
        word: .constant("Naruto"),
        wordDidAppear: {})
}
