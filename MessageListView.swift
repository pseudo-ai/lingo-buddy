//
//  MessageListView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//


import SwiftUI

struct MessageListView: View {
    let messages: [Message]
    let onEdit: (Message) -> Void
    let onShowHistory: (Message) -> Void
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(messages) { msg in
                            Group {
                                if msg.role == .user {
                                    HStack(alignment: .top, spacing: 8) {
                                        UserMessageBubble(text: msg.text, image: msg.image)
                                        Spacer()
                                    }
                                } else if msg.role == .system {
                                    HStack {
                                        Text(msg.text)
                                            .font(.system(size: 12))
                                            .foregroundColor(.white.opacity(0.8))
                                            .padding(6)
                                            .cornerRadius(12)
                                        Spacer()
                                    }
                                }
                                else {
                                    HStack(alignment: .top, spacing: 8) {
                                        AIMessageBubble(
                                            text: msg.text,
                                            structuredContent: msg.structured,
                                            toastMessage: .constant(nil),
                                            onEdit: { onEdit(msg) },
                                            onShowHistory: { onShowHistory(msg) }
                                        )
                                        Spacer()
                                    }
                                }
                            }
                            .id(msg.id)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
            }
            .onChange(of: messages.count) { _, _ in
                if let lastID = messages.last?.id {
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
}
