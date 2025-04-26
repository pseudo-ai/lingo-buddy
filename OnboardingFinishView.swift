//
//  OnboardingFinishView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

struct OnboardingFinishView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var nav: NavigationManager
    var onComplete: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("You're all set to start sounding more natural!")
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text("Let’s begin by analyzing a real chat or message you’ve seen.")
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)

            Image("chameleon")
                .resizable()
                .scaledToFit()
                .frame(width: 160)

            Button(action: {
                nav.switchToChat()
                authVM.saveOnboardingAnswers()
                authVM.isFirstLogin = false
                onComplete()
            }) {
                Text("Start a Chat")
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [Color("#7FD74C"), Color("#E3FA47")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(14)
                    .padding(.horizontal, 40)
            }

            Button("Skip for now", action: {
                onComplete()
                nav.switchToSlang()
                authVM.isFirstLogin = false
            })
                .foregroundColor(.white.opacity(0.7))
                .padding(.top)

            Spacer()
        }
    }
}
