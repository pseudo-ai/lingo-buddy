//
//  SlangTabView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//


import SwiftUI

struct SlangTabView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Slang of the Day
                VStack(alignment: .leading, spacing: 8) {
                    Text("Slang of the Day")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("🅣  ride or die")
                            .font(.title3)
                            .bold()
                            .padding(.bottom, 2)

                        Text("• \"She’s my best friend. She’s totally ride or die — she’ll support me no matter what!\"")
                        Text("• \"You know I’ve got your back. I’m ride or die for you.\"")
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.4))
                    .cornerRadius(12)
                }

                // Video Learning
                VStack(alignment: .leading) {
                    Text("Video Learning")
                        .font(.headline)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(["Lit", "Savage", "Slay"], id: \.self) { label in
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 100, height: 120)
                                        .overlay(
                                            Text(label)
                                                .foregroundColor(.white)
                                                .bold()
                                                .padding(6),
                                            alignment: .bottom
                                        )
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }

                // Challenges
                VStack(alignment: .leading, spacing: 8) {
                    Text("Challenges")
                        .font(.headline)

                    VStack(spacing: 12) {
                        ChallengeRow(icon: "star.fill", title: "Learn 20 new words", subtitle: "Master 20 new slang words to boost your fluency")
                        ChallengeRow(icon: "quote.bubble", title: "Slang in Context", subtitle: "Check if slang is used correctly in real scenes")
                        ChallengeRow(icon: "puzzlepiece.extension", title: "Match the Slang", subtitle: "Match slang words with their meanings")
                    }
                }
            }
            .padding()
        }
    }
}

struct ChallengeRow: View {
    var icon: String
    var title: String
    var subtitle: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .font(.title2)
                .padding(.trailing, 8)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
