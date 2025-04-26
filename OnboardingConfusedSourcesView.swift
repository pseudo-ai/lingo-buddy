//
//  OnboardingConfusedSourcesView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

struct OnboardingConfusedSourcesView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var onNext: () -> Void
    let sources = [
        "Messages from friends", "Work chats (Slack, emails)",
        "Social media posts / memes", "Subtitles in videos",
        "Voice messages", "Other"
    ]

    var body: some View {
        VStack(spacing: 16) {
            progressBar(step: 4)

            Text("Where do you usually see slang that confuses you?")
                .foregroundColor(.white)

            ForEach(sources, id: \.self) { option in
                Button(action: {
                    authVM.onboardingAnswers["sourceConfusion"] = option
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
