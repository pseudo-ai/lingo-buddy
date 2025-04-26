//
//  OnboardingLoadingView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

struct OnboardingLoadingView: View {
    var onComplete: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Getting your slang journey ready…")
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text("We’re tailoring everything based on your goals and vibe.")
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding()

            Image("chameleon")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .rotationEffect(.degrees(15))
                .onAppear {
                    onComplete()
                }

            Spacer()
        }
    }
}
