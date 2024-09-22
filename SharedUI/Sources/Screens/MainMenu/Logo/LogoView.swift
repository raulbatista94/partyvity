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

    @State private var isPInitialAnimationComplete = false
    @State private var isAInitialAnimationComplete = false
    @State private var isRInitialAnimationComplete = false
    @State private var isTInitialAnimationComplete = false
    @State private var isVInitialAnimationComplete = false
    @State private var isYBlueInitialAnimationComplete = false
    @State private var isTGreenInitialAnimationComplete = false
    @State private var isYYellowInitialAnimationComplete = false

    private let stiffness: CGFloat = 200

    @State private var isInitialAnimationComplete = false // Tracks when the initial animation is done

    // Helper function to get random bounce offset
    func randomBounceOffset() -> CGFloat {
        return CGFloat.random(in: -10...10) // Random bounce between -10 and 10 points
    }

    // Helper function to get random scale effect
    func randomScale() -> CGFloat {
        return CGFloat.random(in: 0.9...1.1) // Random scale between 0.9 and 1.1
    }

    var body: some View {
        GeometryReader { reader in
            HStack {
                SwiftUI.Spacer()
                ZStack(alignment: .leading) {
                    // YYellow Letter
                    Image.logoLetterYYellow
                        .offset(
                            x: isYYellowInitialAnimationComplete ? 0 : reader.size.width,
                            y: animateYYellow ? CGFloat.random(in: -10...0) : 0
                        )
                        .scaleEffect(animateYYellow ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateYYellow ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.56)
                        .padding(.top, reader.size.height * 0.6)
                        .onAppear {
                            // Initial animation for moving from right
                            withAnimation(.easeInOut(duration: 0.2).delay(1.3)) {
                                isYYellowInitialAnimationComplete = true
                            }
                            // Continuous playful animation
                            withAnimation(Animation.easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true)
                                .delay(0.1)) {
                                animateYYellow.toggle()
                            }
                        }

                    // TGreen Letter
                    Image.logoLetterTGreen
                        .offset(x: isTGreenInitialAnimationComplete ? 0 : reader.size.width, y: animateTGreen ? randomBounceOffset() : 0)
                        .scaleEffect(animateTGreen ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateTGreen ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.52)
                        .padding(.top, reader.size.height * 0.15)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(1.25)) {
                                isTGreenInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5)
                                .delay(0.2)) {
                                animateTGreen.toggle()
                            }
                        }

                    // I Letter
                    Image.logoLetterI
                        .offset(x: isInitialAnimationComplete ? 0 : reader.size.width, y: animateI ? randomBounceOffset() : 0)
                        .scaleEffect(animateI ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateI ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.50)
                        .padding(.top, reader.size.height * 0.15)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(1.1)) {
                                isInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5)
                                .delay(0.3)) {
                                animateI.toggle()
                            }
                        }

                    // YBlue Letter
                    Image.logoLetterYBlue
                        .offset(x: isYBlueInitialAnimationComplete ? 0 : reader.size.width, y: animateY1 ? randomBounceOffset() : 0)
                        .scaleEffect(animateY1 ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateY1 ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.25)
                        .padding(.top, reader.size.height * 0.5)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(0.8)) {
                                isYBlueInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.4)) {
                                animateY1.toggle()
                            }
                        }

                    // V Letter
                    Image.logoLetterV
                        .offset(x: isVInitialAnimationComplete ? 0 : reader.size.width, y: animateV ? randomBounceOffset() : 0)
                        .scaleEffect(animateV ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateV ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.34)
                        .padding(.top, reader.size.height * 0.35)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(0.7)) {
                                isVInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.5)) {
                                animateV.toggle()
                            }
                        }
//
                    // T Letter
                    Image.logoLetterT
                        .offset(x: isTInitialAnimationComplete ? 0 : reader.size.width, y: animateT ? randomBounceOffset() : 0)
                        .scaleEffect(animateT ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateT ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.23)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(0.6)) {
                                isTInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.6)) {
                                animateT.toggle()
                            }
                        }
//
                    // R Letter
                    Image.logoLetterR
                        .offset(x: isRInitialAnimationComplete ? 0 : reader.size.width, y: animateR ? randomBounceOffset() : 0)
                        .scaleEffect(animateR ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateR ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.18)
                        .padding(.top, reader.size.height * 0.35)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(0.4)) {
                                isRInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.7)) {
                                animateR.toggle()
                            }
                        }

                    // A Letter
                    Image.logoLetterA
                        .offset(x: isAInitialAnimationComplete ? 0 : reader.size.width, y: animateA ? randomBounceOffset() : 0)
                        .scaleEffect(animateA ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateA ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .padding(.leading, reader.size.width * 0.07)
                        .padding(.top, reader.size.height * 0.35)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5).delay(0.2)) {
                                isAInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.8)) {
                                animateA.toggle()
                            }
                        }

                    // P Letter
                    Image.logoLetterP
                        .offset(x: isPInitialAnimationComplete ? 0 : reader.size.width, y: animateP ? randomBounceOffset() : 0)
                        .scaleEffect(animateP ? CGFloat.random(in: 0.9...1.1) : 1.0)
                        .rotationEffect(.degrees(animateP ? CGFloat.random(in: 0...10) : CGFloat.random(in: -10...0)), anchor: .bottom)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.5)) {
                                isPInitialAnimationComplete = true
                            }
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.9)) {
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
