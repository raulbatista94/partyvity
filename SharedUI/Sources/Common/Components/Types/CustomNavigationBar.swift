//
//  SwiftUIView.swift
//
//
//  Created by Raul Batista on 27.12.2023.
//

import SwiftUI

struct CustomNavigationBar: View {
    private let title: String
    private let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        ZStack {
            HeaderBackgroundShape()
                .fill(
                    LinearGradient(
                        colors: [.gradientPurpleLight, .gradientPurpleDark],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .shadow(color: .black, radius: 20, x: 0, y: 10)
                .ignoresSafeArea(edges: .top)

            Text(title)
                .font(.titleMedium)
                .foregroundStyle(Color.white)
                .padding(.bottom, 16)

            HStack {
                Button(
                    action: {
                        action()
                    },
                    label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.white)
                                .padding([.vertical, .leading], 8)
                            
                            Text("Back")
                                .font(.headlineSmall)
                                .foregroundStyle(Color.white)
                                .padding([.vertical, .trailing], 8)
                        }
                        .background(RoundedRectangle(cornerRadius: 16)
                            .fill(Color.backgroundPrimary))
                    })
                .frame(height: 44)
                .padding(.leading, 16)

                SwiftUI.Spacer()

            }
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    CustomNavigationBar(title: "Teams", action: {})
        .frame(height: 104)
}
