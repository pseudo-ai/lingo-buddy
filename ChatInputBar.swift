//
//  ChatInputBar.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//


import SwiftUI
import PhotosUI

struct ChatInputBar: View {
    @Binding var messageText: String
    let onSend: (_ text: String, _ image: UIImage?) -> Void
    let onReset: () -> Void

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        VStack(spacing: 6) {
            // 图片预览区域：在输入框内嵌
            if let image = selectedImage {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .clipped()
                        .cornerRadius(10)
                        .padding(.horizontal, 8)

                    Button(action: {
                        selectedImage = nil
                        selectedItem = nil // ✅ 重置选项，避免选图组件重复加载旧图
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .offset(x: -4, y: 4)
                }
            }

            HStack(spacing: 12) {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Image(systemName: "photo")
                        .frame(width: 40, height: 40)
                        .background(Color("#E6FD4A"))
                        .foregroundColor(.black)
                        .clipShape(Circle())
                }
                .onChange(of: selectedItem) { oldValue, newValue in
                    guard let item = newValue else { return }
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedImage = uiImage
                        }
                    }
                }

                // 绿色边框区域
                HStack {
                    TextField("Write here...", text: $messageText)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                }
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("#E6FD4A"), lineWidth: 1)
                )

                Button(action: {
                    onSend(messageText, selectedImage)
                    messageText = ""
                    selectedImage = nil
                    selectedItem = nil
                }) {
                    Image(systemName: "paperplane.fill")
                        .frame(width: 40, height: 40)
                        .background(Color("#E6FD4A"))
                        .foregroundColor(.black)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
            .background(Color.black.opacity(0.05))
        }
    }
}
