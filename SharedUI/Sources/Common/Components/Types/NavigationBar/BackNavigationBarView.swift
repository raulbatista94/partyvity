//
//  BackNavigationBarView.swift
//  
//
//  Created by Raul Batista on 28.12.2023.
//

import SwiftUI

struct BackNavigationBarView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
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
