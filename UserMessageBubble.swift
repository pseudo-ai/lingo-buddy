//
//  UserMessageBubble.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//


import SwiftUI

struct UserMessageBubble: View {
    var text: String
    var image: UIImage?

    var body: some View {
        HStack {
            Spacer() // 👈 push everything to the right

            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .trailing, spacing: 8) {
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 200)
                                        .cornerRadius(12)
                                }

                                if !text.isEmpty {
                                    Text(text)
                                        .padding()
                                        .background(Color(.systemGray5).opacity(0.3))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        .font(.system(size: 15))
                                }
                            }
//                Image("chameleon")
//                    .resizable()
//                    .frame(width: 32, height: 32)
//                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
    }
}

struct AIMessageBubble: View {
    var text: String
    let structuredContent: GPTStructuredResponse?
    @Binding var toastMessage: String?
    var onEdit: () -> Void
    var onShowHistory: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image("aiavatar")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 8) {
                if let structured = structuredContent {
                    ForEach(Array(structured.result.enumerated()), id: \.offset) { index, entry in
                        if entry.type == "text" {
                            Text(entry.content)
                                .foregroundColor(.white)
                        } else if entry.type == "suggestion" {
                            SuggestionView(index: index, content: entry.content, toastMessage: $toastMessage)
                        }
                    }
                } else {
                    Text(text)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.systemGray5).opacity(0.2))
                        .cornerRadius(12)
                }
            }
            .font(.system(size: 15))

            Spacer()
        }
        .padding(.horizontal)
    }
}

struct SuggestionView: View {
    var index: Int
    var content: String
    @Binding var toastMessage: String?
    @State private var showCopied = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .top) {
                Text("\(index + 1). \(content)")
                    .padding(8)
                    .background(Color(.systemGray5).opacity(0.3))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .font(.system(size: 15))

                Spacer()

                HStack(spacing: 12) {
                    // 📋 复制按钮
                    Image(systemName: "doc.on.doc")
                        .onTapGesture {
                            UIPasteboard.general.string = content
                            toastMessage = "Copied: \(content)"
                            withAnimation { showCopied = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation { showCopied = false }
                            }
                        }
                        .foregroundColor(.white)
                    
                    // 👂 播放语音
                    Image(systemName: "speaker.wave.2.fill")
                        .onTapGesture {
                            SpeechService.shared.speak(text: content)
                        }
                        .foregroundColor(.white)
                }
            }

            if showCopied {
                Text("Copied!")
                    .font(.caption)
                    .padding(4)
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .transition(.opacity)
                    .offset(x: 12, y: -8)
            }
        }
    }
}
