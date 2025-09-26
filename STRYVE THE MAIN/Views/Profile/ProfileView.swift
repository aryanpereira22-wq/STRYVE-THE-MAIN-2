//
//  ProfileView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//

import SwiftUI

struct ProfileView: View {
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
                    .padding(.top, 20)
                    
                    // Stats directly below profile image
                    HStack(spacing: 16) {
                        VStack {
                            Text("\(userStats.rank)")
                                .font(FontTheme.displaySmall)
                                .foregroundColor(.white)
                            Text("Rank")
                                .font(FontTheme.labelSmall)
                                .foregroundColor(.white)
                        }
                        
                        Divider()
                            .frame(height: 40)
                        
                        VStack {
                            Text("\(userStats.level)")
                                .font(FontTheme.displaySmall)
                                .foregroundColor(.white)
                            Text("Level")
                                .font(FontTheme.labelSmall)
                                .foregroundColor(.white)
                        }
                        
                        Divider()
                            .frame(height: 40)
                        
                        VStack {
                            Text("\(userStats.streakDays)")
                                .font(FontTheme.displaySmall)
                                .foregroundColor(.white)
                            Text("Day Streak")
                                .font(FontTheme.labelSmall)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 8)
                    
                    // User Info
                    VStack(spacing: 4) {
                        Text("Aryan Pereira")
                            .font(FontTheme.headlineMedium)
                            .foregroundColor(.white)
                        
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
                
                // Athlete Passport Box
                HStack {
                    Text("Athlete Passport")
                        .font(FontTheme.displaySmall)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                }
                .frame(height: 80)
                .background(ColorTheme.backgroundSecondary)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Friends Box
                HStack {
                    Text("Friends")
                        .font(FontTheme.displaySmall)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                }
                .frame(height: 80)
                .background(ColorTheme.backgroundSecondary)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Recent Activity Section (centered)
                VStack {
                    Text("Recent Activity")
                        .font(FontTheme.headlineMedium)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    ActivityTabView()
                }
                .padding(.top, 20)
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
