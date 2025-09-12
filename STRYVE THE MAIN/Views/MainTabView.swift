//
//  MainTabView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            // Map Tab
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                .tag(1)
            
            // Leaderboard Tab
            LeaderboardView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Rankings")
                }
                .tag(2)
            
            // Challenges Tab
            ChallengesView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Challenges")
                }
                .tag(3)
            
            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(ColorTheme.primaryBlue)
        .onAppear {
            // Set tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(ColorTheme.backgroundPrimary)
            
            // Apply to all tab bars
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

#Preview {
    MainTabView()
}
