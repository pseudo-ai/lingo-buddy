//
//  ProfileTabView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//


import SwiftUI

struct ProfileTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let activeDays = [true, true, true, false, false, true, false] // mock data
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // 🔥 Streak
                VStack(alignment: .leading, spacing: 8) {
                    Text("Streak")
                        .font(.headline)

                    HStack(spacing: 16) {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                            .font(.title2)

                        ForEach(0..<7) { index in
                            VStack(spacing: 4) {
                                Text(weekDays[index])
                                    .font(.caption)
                                    .foregroundColor(.white)

                                Circle()
                                    .fill(activeDays[index] ? Color.black : Color.gray.opacity(0.3))
                                    .frame(width: 12, height: 12)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // 👈 force it to stretch with left alignment
                    .padding(.horizontal, 12) // 👈 equal left/right spacing
                    .padding(.vertical, 8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("#7FD74C"), Color("#E6FD4A")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
                }

                // 📚 Your Words
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Words")
                        .font(.headline)

                    VStack(spacing: 12) {
                        ProfileRow(icon: "star.circle", label: "Collections")
                        ProfileRow(icon: "checkmark.seal", label: "Slang you mastered")
                    }
                }
                
                // ⚙️ Settings
                VStack(alignment: .leading, spacing: 8) {
                    Text("Settings")
                        .font(.headline)
                    
                    Button(action: {
                        authVM.signOut()
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ProfileRow: View {
    var icon: String
    var label: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color("#E6FD4A"))
                .padding(.trailing, 8)
            Text(label)
                .foregroundColor(.black)
            Spacer()
        }
        .padding()
        .background(Color(.systemGray5).opacity(0.2))
        .cornerRadius(10)
    }
}
