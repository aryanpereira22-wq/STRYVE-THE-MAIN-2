//
//  ProfileView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedTab = 0
    @State private var showSettings = false
    @State private var showEditProfile = false
    
    // Mock data
    let userStats = UserStats(
        totalSteps: 1_250_340,
        totalDistance: 845.2,
        totalCalories: 125_430,
        totalWorkouts: 156,
        streakDays: 28,
        level: 15,
        xp: 7_850,
        rank: 24
    )
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 16) {
                    // Profile Image and Stats
                    VStack(spacing: 12) {
                        // Profile Image
                        Button(action: { showEditProfile = true }) {
                          ZStack(alignment: .bottomTrailing) {
                              Image(systemName: "person.circle.fill")
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                                  .frame(width: 90, height: 90)
                                  .foregroundColor(ColorTheme.primaryBlue.opacity(0.2))
            
                              Circle()
                                  .fill(Color.green)
                                  .frame(width: 16, height: 16)
                                  .overlay(Circle().stroke(Color.white, lineWidth: 2))
                           }
                       }
    
                        // Stats
                        HStack(spacing: 16) {
                            VStack {
                                 Text("\(userStats.rank)")
                                    .font(FontTheme.displaySmall)
                                 Text("Rank")
                                    .font(FontTheme.labelSmall)
                            }
        
                            Divider()
                                .frame(height: 40)
        
                            VStack {
                                Text("\(userStats.level)")
                                    .font(FontTheme.displaySmall)
                                Text("Level")
                                    .font(FontTheme.labelSmall)
                            }
        
                            Divider()
                                .frame(height: 40)
        
                            VStack {
                                Text("\(userStats.streakDays)")
                                    .font(FontTheme.displaySmall)
                                Text("Day Streak")
                                    .font(FontTheme.labelSmall)
                            }
                   }
                }
                .padding(.top, 20)

                    
                    // User Info
                    VStack(spacing: 4) {
                        Text("Aryan Pereira")
                            .font(FontTheme.headlineMedium)
                        
                        Text("@aryanp • San Francisco, CA")
                            .font(FontTheme.bodyMedium)
                            .foregroundColor(ColorTheme.textSecondary)
                    }
                    .padding(.horizontal)
                    
                    // Edit Profile Button
                    Button(action: { showEditProfile = true }) {
                        Text("Edit Profile")
                            .font(FontTheme.labelMedium)
                            .foregroundColor(ColorTheme.primaryBlue)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(ColorTheme.primaryBlue.opacity(0.1))
                            .cornerRadius(20)
                    }
                    .padding(.vertical, 12)
                }
                .background(ColorTheme.backgroundSecondary)
                
                // Stats Grid
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    StatCard(icon: "figure.walk", value: "\(userStats.totalSteps.formattedWithSeparator())", label: "Total Steps")
                    StatCard(icon: "map", value: String(format: "%.1f km", userStats.totalDistance), label: "Distance")
                    StatCard(icon: "flame", value: "\(userStats.totalCalories.formattedWithSeparator())", label: "Calories")
                    StatCard(icon: "clock", value: "\(userStats.totalWorkouts)", label: "Workouts")
                }
                .padding()
                
                // Tabs
                Picker("Profile Tabs", selection: $selectedTab) {
                    Text("Activity").tag(0)
                    Text("Achievements").tag(1)
                    Text("Friends").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                // Tab Content Placeholder
                VStack {
                    if selectedTab == 0 {
                        ActivityTabView()
                    } else if selectedTab == 1 {
                        AchievementsTabView()
                    } else {
                        FriendsTabView()
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .background(ColorTheme.backgroundPrimary)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showSettings = true }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(ColorTheme.primaryBlue)
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showEditProfile) {
            EditProfileView()
        }
    }
}

// MARK: - Subviews

// Using shared StatCard component from Components directory

// MARK: - Tab Views

struct ActivityTabView: View {
    var body: some View {
        VStack {
            Text("Activity data will be displayed here")
                .foregroundColor(ColorTheme.textSecondary)
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(ColorTheme.backgroundSecondary)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct AchievementsTabView: View {
    var body: some View {
        VStack {
            Text("Achievements will be displayed here")
                .foregroundColor(ColorTheme.textSecondary)
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(ColorTheme.backgroundSecondary)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct FriendsTabView: View {
    var body: some View {
        VStack {
            Text("Friends will be displayed here")
                .foregroundColor(ColorTheme.textSecondary)
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(ColorTheme.backgroundSecondary)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// MARK: - Data Models

struct UserStats {
    let totalSteps: Int
    let totalDistance: Double
    let totalCalories: Int
    let totalWorkouts: Int
    let streakDays: Int
    let level: Int
    let xp: Int
    let rank: Int
    
    var xpToNextLevel: Int {
        (level + 1) * 1000
    }
    
    var xpProgress: Double {
        Double(xp) / Double(xpToNextLevel)
    }
}

// MARK: - Extensions

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

// MARK: - Preview

#Preview {
    ProfileView()
}
