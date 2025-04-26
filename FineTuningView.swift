//
//  FineTuningView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//

import SwiftUI

struct FineTuningView: View {
    @Binding var isPresented: Bool
    @Binding var targetMessage: Message?
    var onRegenerate: (FineTuneParams, String) -> Void

    var defaultParams: FineTuneParams

    @State private var niceValue: Double
    @State private var sincereValue: Double
    @State private var humorousValue: Double
    @State private var casualValue: Double
    @State private var emojiEnabled: Bool

    init(
        isPresented: Binding<Bool>,
        targetMessage: Binding<Message?>,
        defaultParams: FineTuneParams,
        onRegenerate: @escaping (FineTuneParams, String) -> Void
    ) {
        _isPresented = isPresented
        _targetMessage = targetMessage
        self.onRegenerate = onRegenerate
        self.defaultParams = defaultParams

        _niceValue = State(initialValue: defaultParams.vibes["Nice"] ?? 0.5)
        _sincereValue = State(initialValue: defaultParams.vibes["Sincere"] ?? 0.5)
        _humorousValue = State(initialValue: defaultParams.vibes["Humorous"] ?? 0.5)
        _casualValue = State(initialValue: defaultParams.vibes["Casual"] ?? 0.5)
        _emojiEnabled = State(initialValue: defaultParams.emoji)
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("Adjust How the Reply Sounds")
                .font(.title3)
                .bold()
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 12) {
                Text("Choose the Vibe")
                    .font(.headline)
                    .foregroundColor(.white)

                VibeSlider(labelLeft: "Mean", labelRight: "Nice", value: $niceValue)
                VibeSlider(labelLeft: "Sarcastic", labelRight: "Sincere", value: $sincereValue)
                VibeSlider(labelLeft: "Serious", labelRight: "Humorous", value: $humorousValue)
                VibeSlider(labelLeft: "Professional", labelRight: "Casual", value: $casualValue)
            }

            Toggle(isOn: $emojiEnabled) {
                Label("Include Emoji", systemImage: "face.smiling")
                    .foregroundColor(.white)
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("#E6FD4A")))

            Button(action: {
                let params = FineTuneParams(
                    vibes: [
                        "Nice": niceValue,
                        "Sincere": sincereValue,
                        "Humorous": humorousValue,
                        "Casual": casualValue
                    ],
                    emoji: emojiEnabled
                )

                let toneText = buildTonePrompt(params: params) // ✅ 用已有函数生成提示语
                isPresented = false
                onRegenerate(params, toneText)
            }) {
                Text("Apply")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(colors: [Color("#72CA40"), Color("#E3FA47")], startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.black)
                    .cornerRadius(12)
            }


            Spacer()
        }
        .padding()
        .background(Color(.darkGray).ignoresSafeArea())
    }
}

struct VibeSlider: View {
    let labelLeft: String
    let labelRight: String
    @Binding var value: Double
    let step: Double = 0.25

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(labelLeft)
                    .foregroundColor(.white)
                    .font(.caption)
                Spacer()
                Text(labelRight)
                    .foregroundColor(.white)
                    .font(.caption)
            }

            ZStack {
                // Background segmented track
                HStack(spacing: 1) {
                    ForEach(0..<4) { index in
                        Capsule()
                            .fill(segmentFill(for: index))
                            .frame(height: 6)
                    }
                }
                .padding(.horizontal, 4)

                // Slider thumb
                Slider(value: $value, in: 0...1, step: step)
                    .accentColor(.clear)
                    .padding(.horizontal, 2)
            }
        }
    }
    private func segmentFill(for index: Int) -> Color {
        let filledSegments = Int(round(value / step)) // 0–4
        let activeColor: Color
            switch index {
            case 0, 1:
                activeColor = Color("#B4F455") // green
            case 2, 3, 4:
                activeColor = Color("#E6FD4A") // yellow
            default:
                activeColor = Color.white // fallback
            }

            return index < filledSegments ? activeColor : Color.white.opacity(0.3)
        }
}


struct FineTuneParams {
    let vibes: [String: Double]
    let emoji: Bool
}
