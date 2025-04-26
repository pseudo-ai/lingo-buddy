//
//  OnboardingWelcomeView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    var onNext: () -> Void

    var body: some View {
        ZStack {
            Color(hex: "#303338").ignoresSafeArea()
            VStack(spacing: 24) {
                Spacer()
                
                Text("Hi! I’m ")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                + Text("Leon,")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("#D4FF55"))
                
                Text("Let’s personalize your slang journey!")
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .font(.system(size: 26))
                
                Image("ob-0-4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 267)
                
                Spacer()
                
                Button(action: onNext) {
                    Text("Continue")
                        .foregroundColor(.black)
//                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [Color("#7BD746"),Color("#ECFF51"),Color("#EDF9A9")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(14)
                        .padding(.horizontal, 40)
                }
                
                Spacer().frame(height: 40)
            }
        }
    }
}
