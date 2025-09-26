//
//  LeaderboardView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var selectedTab = 0
    @State private var timeFilter = 0
    @State private var showFilters = false
    
    // Mock data
    let globalRankings = [
        UserRank(id: 1, name: "Alex Johnson", rank: 1, steps: 12450, xp: 12450, isCurrentUser: false, image: nil),
        UserRank(id: 2, name: "You", rank: 2, steps: 11890, xp: 11890, isCurrentUser: true, image: nil),
        UserRank(id: 3, name: "Taylor Swift", rank: 3, steps: 11230, xp: 11230, isCurrentUser: false, image: nil)
    ]
    
    let friendsRankings = [
        UserRank(id: 1, name: "You", rank: 1, steps: 11890, xp: 11890, isCurrentUser: true, image: nil),
        UserRank(id: 2, name: "Alex Johnson", rank: 4, steps: 12450, xp: 12450, isCurrentUser: false, image: nil)
    ]
    
    let timeFilters = ["Daily", "Weekly", "Monthly"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Time Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<timeFilters.count, id: \.self) { index in
                            Button(action: { timeFilter = index }) {
                                Text(timeFilters[index])
                                    .font(FontTheme.labelMedium)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(timeFilter == index ? ColorTheme.primaryBlue : ColorTheme.backgroundSecondary)
                                    .foregroundColor(timeFilter == index ? .white : ColorTheme.textPrimary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding()
                }
                .background(ColorTheme.backgroundPrimary)
                
                // Segmented Control
                Picker("Leaderboard Type", selection: $selectedTab) {
                    Text("Global").tag(0)
                    Text("Friends").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Leaderboard Content
                List {
                    ForEach(selectedTab == 0 ? globalRankings : friendsRankings) { user in
                        LeaderboardRow(user: user)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Rankings")
            .toolbar {
                Button(action: { showFilters = true }) {
                    Image(systemName: "line.3.horizontal.decrease")
                }
            }
			.toolbarBackground(ColorTheme.primaryBlue, for: .navigationBar) 
			.toolbarBackground(.visible, for: .navigationBar)
			.toolbarColorScheme(.dark, for: .navigationBar
            .sheet(isPresented: $showFilters) {
                LeaderboardFilterView(selectedFilter: $selectedTab, filters: ["Global", "Friends"])
            }
        }
    }
}

// MARK: - Subviews

struct LeaderboardRow: View {
    let user: UserRank
    
    var body: some View {
        HStack(spacing: 12) {
            // Rank
            if user.rank <= 3 {
                ZStack {
                    Circle()
                        .fill(rankColor)
                        .frame(width: 30, height: 30)
                    
                    Text("\(user.rank)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            } else {
                Text("\(user.rank)")
                    .font(FontTheme.bodyMedium)
                    .foregroundColor(ColorTheme.textSecondary)
                    .frame(width: 30, alignment: .center)
            }
            
            // Avatar
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(user.isCurrentUser ? ColorTheme.primaryBlue : Color.gray.opacity(0.3))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Text(user.name.prefix(1))
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(user.isCurrentUser ? .white : ColorTheme.textPrimary)
                    )
                
                if user.isCurrentUser {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
            }
            
            // Name and Level
            VStack(alignment: .leading, spacing: 2) {
			    HStack(spacing: 4) {
 			       let displayName = user.isCurrentUser ? "You" : user.name
	               Text(displayName)
            			.font(FontTheme.bodyMedium)
            			.foregroundColor(
               				 (displayName == "Alex Johnson" || displayName == "You" || displayName == "Taylor Swift")
                			? .black
                			: ColorTheme.textPrimary
           				 )
        
        			if user.isCurrentUser {
            			Image(systemName: "checkmark.seal.fill")
                			.font(.system(size: 12))
                			.foregroundColor(ColorTheme.primaryBlue)
        			}
  			  }
    
    		Text("Level \(user.level) • \(user.steps) steps")
        	.font(FontTheme.labelSmall)
        	.foregroundColor(ColorTheme.textSecondary)
		}
            
            Spacer()
            
            // XP
            Text("\(user.xp) XP")
                .font(FontTheme.labelMedium)
                .foregroundColor(ColorTheme.primaryBlue)
        }
        .padding(.vertical, 4)
        .listRowBackground(user.isCurrentUser ? ColorTheme.primaryBlue.opacity(0.1) : Color.clear)
    }
    
    private var rankColor: Color {
        switch user.rank {
        case 1: return ColorTheme.goldRank
        case 2: return ColorTheme.silverRank
        case 3: return ColorTheme.bronzeRank
        default: return ColorTheme.primaryBlue
        }
    }
}

// MARK: - Data Models

struct UserRank: Identifiable {
    let id: Int
    let name: String
    let rank: Int
    let steps: Int
    let xp: Int
    let isCurrentUser: Bool
    let image: String?
    
    // Computed properties
    var level: Int {
        return xp / 1000 + 1
    }
    
    var levelProgress: Double {
        return Double(xp % 1000) / 1000.0
    }
}

// MARK: - Preview

#Preview {
    LeaderboardView()
}
