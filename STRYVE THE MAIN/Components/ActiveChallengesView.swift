import SwiftUI

// Import the Challenge model

/// A view that displays a horizontal scrollable list of active challenges
struct ActiveChallengesView: View {
    // MARK: - Properties
    
    /// The array of active challenges to display
    let challenges: [Challenge]
    
    /// Action handler for when "See All" is tapped
    var onSeeAllTapped: (() -> Void)? = nil
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with title and see all button
            HStack {
                Text("Active Challenges")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(ColorTheme.primaryText)
                
                Spacer()
                
                Button(action: { onSeeAllTapped?() }) {
                    HStack(spacing: 4) {
                        Text("See All")
                            .font(.system(size: 14, weight: .medium))
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .foregroundColor(ColorTheme.accentBlue)
                }
            }
            .padding(.horizontal, 20)
            
            // Horizontal scrollable list of challenges
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Add spacing before first card
                    Spacer()
                        .frame(width: 4)
                    
                    // Challenge cards
                    ForEach(challenges) { challenge in
                        ChallengeCard(challenge: challenge, onAction: {})
                            .frame(width: 280)
                    }
                    
                    // Add spacing after last card
                    Spacer()
                        .frame(width: 4)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Previews

#Preview("With Challenges") {
    ZStack {
        ColorTheme.backgroundPrimary.ignoresSafeArea()
        
        ActiveChallengesView(
            challenges: [
                Challenge(
                    id: 1,
                    title: "10K Steps Daily",
                    description: "Reach 10,000 steps every day this week",
                    type: .step,
                    targetValue: 10000,
                    currentValue: 6000, // 60% of 10,000
                    participants: 24,
                    duration: 7,
                    timeLeft: 3,
                    isJoined: true,
                    icon: "figure.walk",
                    colorHex: "00C6FF"
                ),
                Challenge(
                    id: 2,
                    title: "Hydration Master",
                    description: "Drink 2L of water daily",
                    type: .water,
                    targetValue: 2.0,
                    currentValue: 0.6, // 30% of 2L
                    participants: 15,
                    duration: 7,
                    timeLeft: 7,
                    isJoined: true,
                    icon: "drop.fill",
                    colorHex: "1E90FF"
                ),
                Challenge(
                    id: 3,
                    title: "Morning Runner",
                    description: "Run 5km every morning",
                    type: .distance,
                    targetValue: 5000, // in meters
                    currentValue: 4000, // 4km of 5km
                    participants: 8,
                    duration: 7,
                    timeLeft: 1,
                    isJoined: true,
                    icon: "figure.run",
                    colorHex: "FF6B6B"
                )
            ]
        )
        .padding(.vertical)
    }
}

#Preview("Empty State") {
    ZStack {
        ColorTheme.backgroundPrimary.ignoresSafeArea()
        
        VStack {
            ActiveChallengesView(challenges: [])
            Spacer()
        }
        .padding()
    }
}

#Preview("Single Challenge") {
    ZStack {
        ColorTheme.backgroundPrimary.ignoresSafeArea()
        
        ActiveChallengesView(
            challenges: [
                Challenge(
                    id: 4,
                    title: "Active Minutes",
                    description: "Get 30 active minutes daily",
                    type: .activeMinutes,
                    targetValue: 210, // 30 min * 7 days
                    currentValue: 120, // 2 hours so far
                    participants: 32,
                    duration: 7,
                    timeLeft: 4,
                    isJoined: true,
                    icon: "flame.fill",
                    colorHex: "FF8E53"
                )
            ]
        )
        .padding(.vertical)
    }
}
