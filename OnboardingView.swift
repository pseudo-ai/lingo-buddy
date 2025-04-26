//
//  OnboardingView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//


import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 8) {
                    Text("Hi! I’m ")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    + Text("Leon,")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color("#D4FF55"))

                    Text("Let’s personalize your slang journey!")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                }

                Image("chameleon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                    .shadow(color: .green.opacity(0.3), radius: 10)

                Spacer()

                Button(action: {
                    authVM.isFirstLogin = false // ⬅️ Mark onboarding as completed
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("#D4FF55"))
                        .cornerRadius(14)
                        .padding(.horizontal, 40)
                        .shadow(radius: 4)
                }

                Spacer().frame(height: 40)
            }
        }
    }
}
