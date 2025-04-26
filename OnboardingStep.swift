//
//  OnboardingStep.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//


import SwiftUI

enum OnboardingStep: Int, CaseIterable {
    case welcome, language, cultureFit, soundNatural, confusedSources, loading, finish
}

struct OnboardingContainerView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var currentStep: OnboardingStep = .welcome

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            switch currentStep {
            case .welcome:
                OnboardingWelcomeView { goToNextStep() }
            case .language:
                OnboardingLanguageView { goToNextStep() }
            case .cultureFit:
                OnboardingCultureFitView { goToNextStep() }
            case .soundNatural:
                OnboardingSoundNaturalView { goToNextStep() }
            case .confusedSources:
                OnboardingConfusedSourcesView { goToNextStep() }
            case .loading:
                OnboardingLoadingView {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        goToNextStep()
                    }
                }
            case .finish:
                OnboardingFinishView {
                    authVM.isFirstLogin = false // 🎯 Exit onboarding
                }
            }
        }
        .transition(.slide)
        .animation(.easeInOut, value: currentStep)
    }

    func goToNextStep() {
        if let next = OnboardingStep(rawValue: currentStep.rawValue + 1) {
            currentStep = next
        }
    }
}
