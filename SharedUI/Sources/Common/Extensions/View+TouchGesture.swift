//
//  File.swift
//  
//
//  Created by Raul Batista on 23.12.2023.
//

import SwiftUI

extension View {
    func tapDismissesKeyboard(focusState: FocusState<Bool>) -> some View {
        modifier(DismissKeyboardOnTapModifier(isTextFieldFocused: focusState))
    }
}

private struct DismissKeyboardOnTapModifier: ViewModifier {
    @FocusState var isTextFieldFocused: Bool

    func body(content: Content) -> some View {
        content
            .scrollDismissesKeyboard(.immediately)
            .onTapGesture {
                if isTextFieldFocused {
                    isTextFieldFocused = false
                }
            }
    }
}
