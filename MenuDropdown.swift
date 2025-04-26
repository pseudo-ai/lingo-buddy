//
//  MenuDropdown.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//


import SwiftUI

struct MenuDropdown: View {
    let title: String
    let options: [String]
    @Binding var selection: String

    @State private var isExpanded = false
    @State private var fieldFrame: CGRect = .zero

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Main field
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 16)

                Button(action: {
                    withAnimation { isExpanded.toggle() }
                }) {
                    HStack {
                        Text(selection.isEmpty ? title : selection)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding()
                    .background(GeometryReader { geo -> Color in
                        DispatchQueue.main.async {
                            self.fieldFrame = geo.frame(in: .global)
                        }
                        return Color.clear
                    })
                    .background(Color(hex: "#44494C"))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isExpanded ? Color(hex: "#7FD74C") : Color.clear, lineWidth: 1.5)
                    )
                }
                .padding(.horizontal, 16)
            }

            // Floating, scrollable dropdown
            if isExpanded {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                withAnimation {
                                    selection = option
                                    isExpanded = false
                                }
                            }) {
                                Text(option)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(option == selection ? Color(hex: "#5A5F63") : Color(hex: "#44494C"))
                            }
                        }
                    }
                }
                .frame(width: fieldFrame.width, height: min(CGFloat(options.count) * 44, 220)) // 5 items max height
                .background(Color(hex: "#44494C"))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "#7FD74C"), lineWidth: 1.0)
                )
                .position(x: fieldFrame.midX, y: fieldFrame.maxY + 10)
                .zIndex(1000)
                .shadow(radius: 6)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}
