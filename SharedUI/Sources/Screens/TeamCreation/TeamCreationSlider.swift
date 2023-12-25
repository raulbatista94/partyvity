//
//  TeamCreationSlider.swift
//  
//
//  Created by Raul Batista on 25.12.2023.
//

import SwiftUI

struct TeamCreationSlider: View {
    @Binding var value: Int
    @Binding var thumbImage: Image
    var trackColor: Color
    var progressColor: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(trackColor)
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(progressColor)
                    .frame(
                        width: ((geometry.size.width / FileConstants.maxTeamMembers) * CGFloat(self.value)),
                        height: 8
                    )
                    .animation(.bouncy, value: 1.0)

                thumbImage
                    .resizable()
                    .animation(.interactiveSpring)
                    .frame(width: 24, height: 24)
                    .aspectRatio(contentMode: .fit)
                    .offset(x: ((geometry.size.width / FileConstants.maxTeamMembers) * CGFloat(self.value)) - 15)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            onDragChange(gesture, geometry)
                        }
                    )
            }
        }
    }

    private func onDragChange(
        _ gesture: DragGesture.Value,
        _ geometry: GeometryProxy
    ) {
        let thumbPosition = gesture.location.x
        let initialThumbValue = geometry.size.width / 6
        
        // Clamp positions to min and max
        guard
            thumbPosition >= initialThumbValue,
            thumbPosition <= geometry.size.width
        else {
            return
        }
        
        /// Get the position of the thumb compared to the position in the whole bar,
        /// since we want whole number we need to round them. This formula will give us rounded
        /// step results 1, 2, 3 etc. up to the `maxTeamMember` count.
        let relativePosition = ((thumbPosition / geometry.size.width) * FileConstants.maxTeamMembers).rounded()

        // Value can't be zero
        self.value = Int(max(1, relativePosition))
    }
}

private enum FileConstants {
    static let maxTeamMembers: CGFloat = 6
}

// MARK: - Preview
#Preview {
    TeamCreationSlider(
        value: .constant(1),
        thumbImage: .constant(.avatarAlert), 
        trackColor: .textInputInactive,
        progressColor: .textInputActive
    )
    .padding(.horizontal, 16)
}
