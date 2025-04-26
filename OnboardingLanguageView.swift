//
//  OnboardingLanguageView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

func progressBar(step: Int) -> some View {
    HStack(spacing: 10) {
        ForEach(1...4, id: \.self) { i in
            Capsule()
                .fill(i <= step ? AnyShapeStyle(
                    LinearGradient(
                        colors: [Color(hex: "#81DC59"), Color(hex: "#E4FB4E")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                ) : AnyShapeStyle(Color("#A2A4A6")))
                .frame(height: 9)
        }
    }
    .padding(.top, 40)
    .padding(.horizontal, 40)
}


struct OnboardingLanguageView: View {
    @State private var nativeLanguage = ""
    @State private var culturalBackground = ""
    @EnvironmentObject var authVM: AuthViewModel
    var onNext: () -> Void

    let languageOptions = [
//        "Mandarin", "Korean", "Spanish",
        "English",
//        "Other"
    ]
    let cultureOptions = [
//        "Chinese", "Korean", "Latin American",
        "North American",
//        "Other"
    ]

    var body: some View {
        ZStack {
            Color(hex: "#303338").ignoresSafeArea()

            VStack(spacing: 24) {
                progressBar(step: 1)

                VStack(alignment: .leading, spacing: 65) {
                    MenuDropdown(title: "My native language", options: languageOptions, selection: $nativeLanguage)

                    MenuDropdown(title: "My cultural background", options: cultureOptions, selection: $culturalBackground)
                }

                Spacer()

                Button(action: {
                    authVM.onboardingAnswers["nativeLanguage"] = nativeLanguage
                    authVM.onboardingAnswers["culturalBackground"] = culturalBackground
                    onNext()
                }) {
                    Text("Continue")
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(colors: [
                                Color(hex: "#7BD746"),
                                Color(hex: "#ECFF51"),
                                Color(hex: "#EDF9A9")
                            ], startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(14)
                        .padding(.horizontal, 40)
                }

                Spacer().frame(height: 40)
            }
        }
    }
}
