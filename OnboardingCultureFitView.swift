//
//  OnboardingCultureFitView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

struct OnboardingCultureFitView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var onNext: () -> Void

    var body: some View {
        ZStack {
            Color(hex: "#303338").ignoresSafeArea()
            VStack(spacing: 16) {
                progressBar(step: 2)
                
                Text("Which culture do you want to fit in with?")
                    .foregroundColor(.white)
                
                ForEach([
                    "US culture",
//                    "Global internet slang"
                ], id: \.self) { option in
                    Button(action: {
                        authVM.onboardingAnswers["preferredCulture"] = option
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
}
