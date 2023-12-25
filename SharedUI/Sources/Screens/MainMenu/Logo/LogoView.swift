//
//  LogoView.swift
//  
//
//  Created by Raul Batista on 17.12.2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        GeometryReader { reader in
            HStack {
                SwiftUI.Spacer()
                ZStack(alignment: .leading) {
                    Image.logoLetterYYellow
                        .padding(.leading, reader.size.width * 0.56)
                        .padding(.top, reader.size.height * 0.6)
                    Image.logoLetterTGreen
                        .padding(.leading, reader.size.width * 0.52)
                        .padding(.top, reader.size.height * 0.15)
                    Image.logoLetterI
                        .padding(.leading, reader.size.width * 0.50)
                        .padding(.top, reader.size.height * 0.15)
                    Image.logoLetterYBlue
                        .padding(.leading, reader.size.width * 0.25)
                        .padding(.top, reader.size.height * 0.5)
                    Image.logoLetterV
                        .padding(.leading, reader.size.width * 0.34)
                        .padding(.top, reader.size.height * 0.35)
                    Image.logoLetterT
                        .padding(.leading, reader.size.width * 0.23)
                    Image.logoLetterR
                        .padding(.leading, reader.size.width * 0.18)
                        .padding(.top, reader.size.height * 0.35)
                    Image.logoLetterA
                        .padding(.leading, reader.size.width * 0.07)
                        .padding(.top, reader.size.height * 0.35)
                    Image.logoLetterP
                }
                SwiftUI.Spacer()
            }
        }
        .frame(height: 150)
    }
}

#Preview {
    LogoView()
}
