//
//  HomePageView.swift
//  lingo buddy
//
//  Created by 赵千慧 on 2025/4/13.
//


import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var navManager: NavigationManager
    @EnvironmentObject var authVM: AuthViewModel
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color("#101415"))

        let itemAppearance = UITabBarItemAppearance()

        // 🔹 未选中样式
        itemAppearance.normal.iconColor = UIColor(Color("#9E9E9E"))
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(Color("#9E9E9E")),
            .font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ]

        // 🔸 选中样式
        itemAppearance.selected.iconColor = UIColor.white
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ]

        appearance.stackedLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

        // 设置全局选中/未选中颜色（更保险）
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("#9E9E9E"))
    }


    var body: some View {
        TabView(selection: $navManager.selectedTab) {
            SlangTabView()
                .tabItem {
                    Image("slang").renderingMode(.template)
                    Text("Slang")
                }
                .tag(AppTab.slang)

            ChatTabView()
                .tabItem {
                    Image("chat").renderingMode(.template)
                    Text("Chat")
                }
                .tag(AppTab.chat)
                .environmentObject(authVM)

            ProfileTabView()
                .tabItem {
                    Image("profile").renderingMode(.template)
                    Text("Profile")
                }
                .tag(AppTab.profile)
        }
        .background(Color("#101415"))
        .environmentObject(authVM)
    }
}
