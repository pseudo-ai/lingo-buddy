//
//  LoginView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("#7FD74C"), Color("#E6FD4A")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 139, height: 139)

                Image("chameleon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 102, height: 102)
            }

            // Text below the icon
//                Text("Welcome to My App")
//                    .font(.title)
//                    .foregroundColor(.white)
                
            Button(action: {
                authVM.signInWithGoogle()
            }) {
                HStack {
                    Image(systemName: "globe") // Or replace with your Google icon
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Sign up / Login with Google")
                        .fontWeight(.semibold)
                }
                .foregroundColor(Color("#7FD74C"))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 4)
            }
            .padding(.horizontal, 40)

            Button(action: {
                authVM.signInAnonymously()
            }) {
                HStack {
                    Text("Anonymous Mode")
                        .fontWeight(.semibold)
                }
                .foregroundColor(Color("#7FD74C"))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 4)
            }
            .contentShape(Rectangle()) // 👈 Add this
            .padding(.horizontal, 40)
        }
        }
    }
}
