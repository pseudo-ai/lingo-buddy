//
//  AppTab.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/19.
//


import SwiftUI

enum AppTab {
    case slang, chat, profile
}

class NavigationManager: ObservableObject {
    @Published var selectedTab: AppTab = .chat

    func switchToChat() {
        selectedTab = .chat
    }

    func switchToSlang() {
        selectedTab = .slang
    }

    func switchToProfile() {
        selectedTab = .profile
    }
}
