//
//  AISuggestionBlock.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//

import SwiftUI

import SwiftUI

struct AISuggestionBlock: View {
    let structured: GPTStructuredResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(structured.result.enumerated()), id: \.offset) { index, entry in
                Group {
                    if entry.type == "text" {
                        Text(entry.content)
                            .foregroundColor(.white)
                            .font(.body)
                    } else if entry.type == "suggestion" {
                        HStack(alignment: .top) {
                            Text("\(index). \(highlighted(entry.content))")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.white.opacity(0.12))
                                .cornerRadius(8)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15))
                                .fixedSize(horizontal: false, vertical: true)

                            Spacer(minLength: 4)

                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }

    // 关键词高亮逻辑（可拓展）
    func highlighted(_ text: String) -> AttributedString {
        var attributed = AttributedString(text)
        let termsToHighlight = ["cracking up", "slay", "no cap", "lit", "bet", "Hi", "Hey", "hi", "hey"] // 可扩展 slang

        for term in termsToHighlight {
            if let range = attributed.range(of: term, options: .caseInsensitive) {
                attributed[range].foregroundColor = .green
                attributed[range].font = .system(size: 15, weight: .semibold)
            }
        }
        return attributed
    }
}
