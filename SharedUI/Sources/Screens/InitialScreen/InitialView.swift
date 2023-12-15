//
//  InitialView.swift
//  
//
//  Created by Raul Batista on 13.12.2023.
//

import SwiftUI

public struct InitialView: View {
    public var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                ActionButton(
                    onTap: {
                    
                    }, 
                    title: AppStrings.newGame,
                    style: .primary
                )
                .frame(height: 64)
                .padding(.horizontal, 16)
                                
                ActionButton(
                    onTap: {
                    
                    },
                    title: AppStrings.continue,
                    style: .secondary
                )
                .frame(height: 64)
                .padding(.horizontal, 16)
                
                ActionButton(
                    onTap: {
                    
                    },
                    title: AppStrings.previousGames,
                    style: .tertiary
                )
                .frame(height: 64)
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, 0)
        }
    }
    
    public init() { }
}

#Preview {
    InitialView()
}
