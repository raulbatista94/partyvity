//
//  LogoView.swift
//  
//
//  Created by Raul Batista on 17.12.2023.
//

import SwiftUI

import SwiftUI

struct LogoView: View {
    @State private var animateP = false
    @State private var animateA = false
    @State private var animateR = false
    @State private var animateT = false
    @State private var animateV = false
    @State private var animateY1 = false
    @State private var animateI = false
    @State private var animateTGreen = false
    @State private var animateYYellow = false

    var body: some View {
        GeometryReader { reader in
            HStack {
                SwiftUI.Spacer()
                ZStack(alignment: .leading) {
                    Image.logoLetterYYellow
                        .rotationEffect(.degrees(animateYYellow ? 10 : -10), anchor: .bottom)
                        .offset(y: animateYYellow ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.56)
                        .padding(.top, reader.size.height * 0.6)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.1)) {
                                animateYYellow.toggle()
                            }
                        }

                    Image.logoLetterTGreen
                        .rotationEffect(.degrees(animateTGreen ? 10 : -10), anchor: .bottom)
                        .offset(y: animateTGreen ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.52)
                        .padding(.top, reader.size.height * 0.15)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.2)) {
                                animateTGreen.toggle()
                            }
                        }

                    Image.logoLetterI
                        .rotationEffect(.degrees(animateI ? 10 : -10), anchor: .bottom)
                        .offset(y: animateI ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.50)
                        .padding(.top, reader.size.height * 0.15)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.3)) {
                                animateI.toggle()
                            }
                        }

                    Image.logoLetterYBlue
                        .rotationEffect(.degrees(animateY1 ? 10 : -10), anchor: .bottom)
                        .offset(y: animateY1 ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.25)
                        .padding(.top, reader.size.height * 0.5)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.4)) {
                                animateY1.toggle()
                            }
                        }

                    Image.logoLetterV
                        .rotationEffect(.degrees(animateV ? 10 : -10), anchor: .bottom)
                        .offset(y: animateV ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.34)
                        .padding(.top, reader.size.height * 0.35)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.5)) {
                                animateV.toggle()
                            }
                        }

                    Image.logoLetterT
                        .rotationEffect(.degrees(animateT ? 10 : -10), anchor: .bottom)
                        .offset(y: animateT ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.23)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.6)) {
                                animateT.toggle()
                            }
                        }

                    Image.logoLetterR
                        .rotationEffect(.degrees(animateR ? 10 : -10), anchor: .bottom)
                        .offset(y: animateR ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.18)
                        .padding(.top, reader.size.height * 0.35)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.7)) {
                                animateR.toggle()
                            }
                        }

                    Image.logoLetterA
                        .rotationEffect(.degrees(animateA ? 10 : -10), anchor: .bottom)
                        .offset(y: animateA ? -10 : 0)
                        .padding(.leading, reader.size.width * 0.07)
                        .padding(.top, reader.size.height * 0.35)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.8)) {
                                animateA.toggle()
                            }
                        }

                    Image.logoLetterP
                        .rotationEffect(.degrees(animateP ? 10 : -10), anchor: .bottom)
                        .offset(y: animateP ? -10 : 0)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.9)) {
                                animateP.toggle()
                            }
                        }
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
