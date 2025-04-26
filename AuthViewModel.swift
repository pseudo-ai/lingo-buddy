//
//  AuthViewModel.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//
import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var userEmail: String = ""
    @Published var isFirstLogin = false // ✅ 添加这个变量
    
    @Published var onboardingAnswers: [String: Any] = [:]
    private let db = Firestore.firestore()
    
    func saveChatSession(_ session: ChatSession) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let doc = db.collection("users").document(uid).collection("chatSessions").document(session.id.uuidString)

        doc.setData([
            "title": session.title,
            "messages": session.messages.map { ["role": $0.role.rawValue, "text": $0.text] },
            "createdAt": Timestamp()
        ]) { error in
            if let error = error {
                print("❌ Failed to save chat session: \(error.localizedDescription)")
            } else {
                print("✅ Chat session saved.")
            }
        }
    }

    
    func saveOnboardingAnswers() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("❌ No UID to save onboarding data")
            return
        }

        db.collection("users").document(uid).setData(onboardingAnswers, merge: true) { error in
            if let error = error {
                print("❌ Failed to save onboarding answers: \(error.localizedDescription)")
            } else {
                print("✅ Onboarding answers saved for \(uid)")
            }
        }
    }

    func signInAnonymously() {
        print("👤 Signing in anonymously...")
        Auth.auth().signInAnonymously { [weak self] authResult, error in
            if let error = error {
                print("❌ Anonymous sign-in failed: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                DispatchQueue.main.async {
                    self?.userEmail = "anonymous"
                    self?.isSignedIn = true
                    self?.isFirstLogin = authResult?.additionalUserInfo?.isNewUser ?? false // ✅ 判断首次登录
                    print("✅ Signed in anonymously as \(user.uid), firstLogin: \(self?.isFirstLogin ?? false)")
                }
            }
        }
    }

    // MARK: - Shared Firebase Sign-In Handler
    private func firebaseSignIn(with credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("❌ Firebase sign-in error: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                DispatchQueue.main.async {
                    self.userEmail = user.email ?? "unknown"
                    self.isSignedIn = true
                    self.isFirstLogin = authResult?.additionalUserInfo?.isNewUser ?? false // ✅ 判断首次登录
                    print("✅ Signed in as \(self.userEmail), firstLogin: \(self.isFirstLogin)")
                }
            }
        }
    }

    // MARK: - Sign-Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            self.userEmail = ""
            self.isFirstLogin = false // ✅ 清空首次登录状态
            print("👋 Signed out.")
        } catch {
            print("❌ Sign-out failed: \(error.localizedDescription)")
        }
    }

    func signInWithGoogle() {
        print("Signing in ...")
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("❌ No Firebase client ID")
            return
        }

        let config = GIDConfiguration(clientID: clientID)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("❌ No root view controller")
            return
        }

        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("❌ Google sign-in error: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("❌ No user or token")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("❌ Firebase Auth error: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self.userEmail = authResult?.user.email ?? "unknown"
                        self.isSignedIn = true
                        self.isFirstLogin = authResult?.additionalUserInfo?.isNewUser ?? false // ✅ 判断首次登录
                        print("✅ Signed in as \(self.userEmail), firstLogin: \(self.isFirstLogin)")
                    }
                }
            }
        }
    }
}
