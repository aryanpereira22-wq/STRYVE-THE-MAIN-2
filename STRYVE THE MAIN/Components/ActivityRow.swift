import SwiftUI

/// A row component for displaying activity items in a list
struct ActivityRow: View {
    // MARK: - Properties
    let icon: String
    let type: String
    let time: String
    let duration: String?
    let distance: String?
    let calories: String?
    let sets: String?
    let exercises: String?

    // MARK: - Computed Properties
    private var iconColor: Color {
        switch icon {
        case "figure.run": return ColorTheme.accentBlue
        case "dumbbell.fill": return ColorTheme.accentTeal
        case "heart.fill": return ColorTheme.accentPink
        case "bicycle": return ColorTheme.accentPurple
        case "figure.walk": return ColorTheme.accentTeal
        case "figure.highintensity.intervaltraining": return ColorTheme.accentOrange
        default: return ColorTheme.accentBlue
        }
    }

    // MARK: - Init
    init(icon: String,
         type: String,
         time: String,
         duration: String? = nil,
         distance: String? = nil,
         calories: String? = nil,
         sets: String? = nil,
         exercises: String? = nil) {
        self.icon = icon
        self.type = type
        self.time = time
        self.duration = duration
        self.distance = distance
        self.calories = calories
        self.sets = sets
        self.exercises = exercises
    }

    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            // Activity Icon with Gradient Background
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [iconColor.opacity(0.2), iconColor.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 44, height: 44)

                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(iconColor)
            }

            // Activity Details
            VStack(alignment: .leading, spacing: 8) {
                // Type and Time
                HStack {
                    Text(type)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(ColorTheme.primaryText)

                    Spacer()

                    Text(time)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(ColorTheme.textTertiary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(ColorTheme.backgroundTertiary)
                        .cornerRadius(10)
                }

                // Stats Row
                HStack(spacing: 16) {
                    if let duration = duration {
                        statItem(icon: "clock", value: duration, color: ColorTheme.textSecondary)
                    }

                    if let distance = distance {
                        statItem(icon: "point.topleft.down.curvedto.point.bottomright.up", value: distance, color: ColorTheme.textSecondary)
                    }

                    if let calories = calories {
                        statItem(icon: "flame", value: "\(calories) cal", color: ColorTheme.textSecondary)
                    }

                    if let sets = sets {
                        statItem(icon: "square.stack.3d.up", value: "\(sets) sets", color: ColorTheme.textSecondary)
                    }

                    if let exercises = exercises {
                        statItem(icon: "list.bullet", value: "\(exercises) ex", color: ColorTheme.textSecondary)
                    }
                }
                .padding(.top, 2)
            }

            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(ColorTheme.textTertiary)
                .opacity(0.7)
        }
        .padding(16)
        .background(ColorTheme.backgroundSecondary)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(ColorTheme.backgroundTertiary, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    // MARK: - Helper Views
    private func statItem(icon: String, value: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(color.opacity(0.8))

            Text(value)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(color)
        }
    }
}


// MARK: - Previews
struct ActivityRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Minimal sizeThatFits preview
            ActivityRow(
                icon: "figure.walk",
                type: "Evening Walk",
                time: "8:20 PM",
                duration: "25 min"
            )
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .previewDisplayName("Minimal Activity")

            // Full sample list preview on dark background
            ZStack {
                ColorTheme.backgroundPrimary.ignoresSafeArea()

                VStack(spacing: 16) {
                    ActivityRow(
                        icon: "figure.run",
                        type: "Morning Run",
                        time: "9:30 AM",
                        duration: "32:45",
                        distance: "5.2 km",
                        calories: "420"
                    )
                    .padding(.horizontal)

                    ActivityRow(
                        icon: "dumbbell.fill",
                        type: "Chest & Back",
                        time: "7:15 AM",
                        duration: "45 min",
                        sets: "12",
                        exercises: "8"
                    )
                    .padding(.horizontal)

                    ActivityRow(
                        icon: "bicycle",
                        type: "Evening Ride",
                        time: "6:45 PM",
                        duration: "1:22:15",
                        distance: "22.7 km",
                        calories: "780"
                    )
                    .padding(.horizontal)
                }
            }
            .preferredColorScheme(.dark)
            .previewDisplayName("Activity List")
        }
    }
}
