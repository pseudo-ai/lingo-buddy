//
//  OnboardingSoundNaturalView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

struct OnboardingSoundNaturalView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var onNext: () -> Void
    let options = ["In school", "At work", "On social media", "With friends or group chats", "In dating"]

    var body: some View {
        VStack(spacing: 16) {
            progressBar(step: 3)

            Text("Where do you want to sound more natural?")
                .foregroundColor(.white)

            ForEach(options, id: \.self) { option in
                Button(action: {
                    authVM.onboardingAnswers["soundNaturalContext"] = option
                    onNext()
                }) {
                    Text(option)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }

            Spacer()
        }
    }
}
