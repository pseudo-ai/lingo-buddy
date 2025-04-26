//
//  IntroView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//


import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        default:
            r = 0; g = 0; b = 0
        }
        self.init(red: r, green: g, blue: b)
    }
}


struct IntroView: View {
    @Binding var hasStartedConversation: Bool
    @Binding var selectedRole: String?
    var onStartChat: ((String) -> Void)? = nil

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 16) {
                Text("Want to speak like a native?")
                    .font(.system(size: 22, weight: .semibold))
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#72CA40"), Color(hex: "#E3FA47")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            Text("Want to speak like a native?")
                                .font(.system(size: 22, weight: .semibold))
                        )
                    )

                Text("Show me your chats— I’ll help you speak more like a native!")
                    .font(.system(size: 15))
                    .foregroundColor(.white)

                HStack(alignment: .center, spacing: 12) {
                    Image("aiavatar")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                    Text("Who do you want to chat with?")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                }

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 76), spacing: 7)], spacing: 7) {
                    ForEach(["Lover", "Family", "Friends", "Colleague", "Subordinate", "Supervisor", "Client", "Stranger"], id: \ .self) { role in
                        Text(role)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                selectedRole == role ? Color(red: 0.93, green: 0.98, blue: 0.29) : Color.gray.opacity(0.2)
                            )
                            .cornerRadius(8)
                            .contentShape(Rectangle())
                            .font(.system(size: 12))
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { _ in selectedRole = role }
                                    .onEnded { _ in
//                                        selectedRole = nil;
                                        hasStartedConversation = true
                                        onStartChat?("")
//                                        let introMessage = "Hey!"
//                                        ChatService.shared.sendToGPT(prompt: introMessage, selectedRole: role) { response in
//                                                    messages.append(.init(role: .ai, text: response))
//                                                }
                                    }
                            )
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}
