//
//  ContentView.swift
//  lingo buddy
//
//  Created by Chloe Qianhui Zhao on 2025/4/1.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import UIKit

extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)

        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if authVM.isSignedIn {
//                if authVM.isFirstLogin {
////                    OnboardingContainerView()
//                } else {
                    HomePageView()
//                }
            } else {
                LoginView()
            }

        }
        .onAppear {
            if let user = Auth.auth().currentUser {
                authVM.isSignedIn = true
                authVM.userEmail = user.email ?? "unknown"
                print("🔄 Restored session for \(authVM.userEmail)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
        .environmentObject(AuthViewModel())
        .environmentObject(NavigationManager())
}
