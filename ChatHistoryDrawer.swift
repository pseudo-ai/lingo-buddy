//
//  ChatHistoryDrawer.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/20.
//

import SwiftUI

struct ChatHistoryDrawer: View {
    var sessions: [ChatSession]
    var onSelect: (ChatSession?) -> Void
    var onClose: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Lingo Buddy")
                .font(.title2.bold())
                .padding(.horizontal)
                .padding(.top, 32)
                .foregroundColor(.white)

            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.horizontal)
            }

            Button(action: {
                onClose()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    onSelect(nil) // Do not save immediately
                }
            }) {
                HStack {
                    Image(systemName: "plus.bubble")
                    Text("Start a new chat")
                        .fontWeight(.semibold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.horizontal)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(groupedSessions, id: \.title) { group in
                        ChatSection(title: group.title, sessions: group.sessions, onSelect: onSelect)
                    }
                }
                .padding(.top, 8)
            }


            .padding(.horizontal)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.darkGray))
        .overlay(
            HStack {
                Spacer()
                VStack {
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 40)
                    Spacer()
                }
                .padding(.trailing)
            }
        )
    }
    
    // 🧠 Group sessions by relative date
    private var groupedSessions: [(title: String, sessions: [ChatSession])] {
        let now = Date()
        let calendar = Calendar.current

        let today = sessions.filter { calendar.isDateInToday($0.createdAt) }
        let within7Days = sessions.filter {
            !calendar.isDateInToday($0.createdAt) &&
            calendar.dateComponents([.day], from: $0.createdAt, to: now).day ?? 0 < 7
        }
        let within30Days = sessions.filter {
            let days = calendar.dateComponents([.day], from: $0.createdAt, to: now).day ?? 0
            return days >= 7 && days <= 30
        }

        return [
            ("Today", today),
            ("Within 7 days", within7Days),
            ("Within 30 days", within30Days)
        ]
    }

}

struct ChatSection: View {
    let title: String
    let sessions: [ChatSession]
    var onSelect: (ChatSession?) -> Void

    var body: some View {
        if !sessions.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .foregroundColor(.white.opacity(0.7))
                    .font(.footnote)
                ForEach(sessions) { session in
                    HStack {
                        Button(action: { onSelect(session) }) {
                            Text(session.title.isEmpty ? "(untitled)" : session.title)
                                .foregroundColor(.white)
                                .lineLimit(1)
                        }
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
    }
}
