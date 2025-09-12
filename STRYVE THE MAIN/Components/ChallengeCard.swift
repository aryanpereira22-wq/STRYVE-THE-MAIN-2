import SwiftUI

// Import the Challenge model

/// A card component for displaying fitness challenges with progress tracking
struct ChallengeCard: View {
    // MARK: - Properties
    
    /// The challenge data to display
    let challenge: Challenge
    
    /// Optional action handler for the primary button
    var onAction: (() -> Void)? = nil
    
    // MARK: - Computed Properties
    
    private var isActive: Bool { challenge.isJoined }
    private var progressText: String { "\(Int(challenge.progress * 100))%" }
    private var participantsText: String { "\(challenge.participants) \(challenge.participants == 1 ? "Person" : "People")" }
    private var progressBarHeight: CGFloat { 6.0 }
    private var progressBarCornerRadius: CGFloat { progressBarHeight / 2 }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with icon, title, and time left
            HStack(alignment: .top, spacing: 12) {
                // Icon with gradient background
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [challenge.color.opacity(0.2), challenge.color.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: challenge.icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(challenge.color)
                }
                
                // Title and description
                VStack(alignment: .leading, spacing: 4) {
                    Text(challenge.title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(challenge.description)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(ColorTheme.textSecondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Time left badge (only for active challenges)
                if isActive {
                    Text("\(challenge.timeLeft)d")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(challenge.color)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(challenge.color.opacity(0.1))
                        .cornerRadius(12)
                }
            }
            
            // Progress section
            VStack(spacing: 12) {
                // Progress header with percentage and participants
                HStack {
                    // Progress percentage with icon
                    HStack(spacing: 6) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(challenge.color)
                        
                        Text(progressText)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(ColorTheme.textPrimary)
                    }
                    
                    Spacer()
                    
                    // Participants with icon
                    HStack(spacing: 6) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ColorTheme.textSecondary)
                        
                        Text(participantsText)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(ColorTheme.textSecondary)
                    }
                }
                
                // Progress bar with gradient
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background track
                        Capsule()
                            .fill(ColorTheme.backgroundTertiary)
                            .frame(height: progressBarHeight)
                        
                        // Progress track with gradient
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [challenge.color, challenge.color.opacity(0.7)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(
                                width: min(CGFloat(challenge.progress) * geometry.size.width, geometry.size.width),
                                height: progressBarHeight
                            )
                            .shadow(color: challenge.color.opacity(0.3), radius: 2, x: 0, y: 1)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: challenge.progress)
                    }
                }
                .frame(height: progressBarHeight)
                
                // Progress details
                HStack {
                    // Current and target values
                    Text("\(challenge.currentValueFormatted) / \(challenge.targetValueFormatted)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(ColorTheme.textTertiary)
                    
                    Spacer()
                    
                    // Time remaining or challenge duration
                    if isActive {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.system(size: 11, weight: .bold))
                            
                            Text("\(challenge.timeLeft) \(challenge.timeLeft == 1 ? "day" : "days") left")
                        }
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(ColorTheme.textSecondary)
                    } else {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                                .font(.system(size: 11, weight: .bold))
                            
                            Text("\(challenge.duration) days")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(ColorTheme.textSecondary)
                    }
                }
            }
            .padding(.top, 4)
            
            // Action Button
            if let action = onAction {
                Button(action: action) {
                    HStack(spacing: 8) {
                        if isActive {
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 16, weight: .semibold))
                        } else {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                        Text(isActive ? "View Progress" : "Join Challenge")
                            .font(.system(size: 15, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [challenge.color, challenge.color.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(14)
                    .shadow(color: challenge.color.opacity(0.3), radius: 10, x: 0, y: 4)
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .padding(16)
        .background(
            ZStack {
                // Base background
                RoundedRectangle(cornerRadius: 20)
                    .fill(ColorTheme.backgroundSecondary)
                
                // Subtle border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(ColorTheme.backgroundTertiary, lineWidth: 1)
            }
        )
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}

// MARK: - Button Style

private struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Previews

#Preview("Challenge Card - Joined") {
    ChallengeCard(
        challenge: Challenge(
            id: 1,
            title: "7-Day Step Challenge",
            description: "Walk 70,000 steps this week",
            type: .step,
            targetValue: 70000,
            currentValue: 45500,
            participants: 24,
            duration: 7,
            timeLeft: 3,
            isJoined: true,
            icon: "figure.walk",
            colorHex: "007AFF" // Blue
        )
    )
    .padding()
}

#Preview("Challenge Card - Not Joined") {
    ChallengeCard(
        challenge: Challenge(
            id: 2,
            title: "5K Run Challenge",
            description: "Run 5 kilometers this week",
            type: .distance,
            targetValue: 5000, // meters
            currentValue: 0,
            participants: 15,
            duration: 7,
            timeLeft: 4,
            isJoined: false,
            icon: "figure.run",
            colorHex: "34C759" // Green
        )
    )
    .padding()
}

#Preview("Challenge Card - Active Minutes") {
    ChallengeCard(
        challenge: Challenge(
            id: 3,
            title: "Active Minutes",
            description: "Reach 150 active minutes this week",
            type: .activeMinutes,
            targetValue: 150,
            currentValue: 90,
            participants: 42,
            duration: 7,
            timeLeft: 2,
            isJoined: true,
            icon: "flame.fill",
            colorHex: "FF9500" // Orange
        )
    )
    .padding()
}
