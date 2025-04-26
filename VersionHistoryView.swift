//
//  VersionHistoryView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//


import SwiftUI

struct VersionHistoryView: View {
    var message: Message
    var onRestore: (String) -> Void

    var body: some View {
        NavigationView {
            List {
                ForEach(message.versions.reversed(), id: \.self) { version in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(version)
                            .font(.body)
                        Button("Restore") {
                            onRestore(version)
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                }

                if message.versions.isEmpty {
                    Text("No version history available.")
                        .foregroundColor(.gray)
                        .italic()
                        .padding()
                }
            }
            .navigationTitle("Edit History")
            .navigationBarItems(trailing: Button("Done") {
                onRestore(message.text) // close without change
            })
        }
    }
}
