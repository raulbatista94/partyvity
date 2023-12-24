//
//  SwiftUIView.swift
//  
//
//  Created by Raul Batista on 20.12.2023.
//

import SwiftUI

public struct InputFieldViewContainer: View {
    @Binding var text: String
    let didFinishEditing: () -> Void

    public var body: some View {
        InputFieldView(
            text: $text,
            didFinishEditing: didFinishEditing
        )
    }
}

struct InputFieldView: View {
    @Binding var text: String
    @FocusState var isFocused: Bool {
        willSet {
            if newValue == false && !text.isEmpty {
                didFinishEditing()
            }
        }
    }

    let didFinishEditing: () -> Void
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 17)
                .foregroundStyle(isFocused
                                 ? Color.textInputActive
                                 : Color.textInputInactive)
                .shadow(radius: 2)

            RoundedRectangle(cornerRadius: 17)
                .foregroundStyle(Color.white)
                .padding(7)

            TextField(
                "",
                text: $text,
                prompt: Text("Team name")
                    .foregroundColor(.gray)
            )
            .font(.bodySmall)
            .focused($isFocused)
            .padding(.horizontal, 12)
        }
    }
}

#Preview {
    InputFieldView(text: .constant(""), didFinishEditing: {})
        .frame(height: 64)
}
