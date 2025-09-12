import SwiftUI

/// A card component for displaying statistics with optional progress indicator
struct StatCard: View {
    // MARK: - Properties
    let icon: String
    let value: String
    let label: String
    var progress: Double? = nil
    var color: Color = ColorTheme.primaryBlue
    var secondaryText: String? = nil
    var showGradient: Bool = false

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Header with icon and optional percentage
            HStack(alignment: .center) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 40, height: 40)

                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(color)
                }

                Spacer()

                if let progress = progress {
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(ColorTheme.textSecondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(ColorTheme.backgroundTertiary)
                        .cornerRadius(12)
                }
            }

            // Small spacer to separate header and value
            Spacer(minLength: 4)

            // Main value
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(ColorTheme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            // Label
            Text(label.uppercased())
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ColorTheme.textSecondary)
                .kerning(0.5)

            // Secondary text
            if let secondaryText = secondaryText {
                Text(secondaryText)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(ColorTheme.textTertiary)
                    .padding(.top, -4)
            }

            // Progress bar
            if let progress = progress {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background track
                        Capsule()
                            .fill(ColorTheme.backgroundTertiary)
                            .frame(height: 6)

                        // Progress track with conditional gradient or solid color
                        if showGradient {
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [color, color.opacity(0.7)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: min(CGFloat(progress) * geometry.size.width, geometry.size.width), height: 6)
                                .shadow(color: color.opacity(0.3), radius: 3, x: 0, y: 1)
                        } else {
                            Capsule()
                                .fill(color)
                                .frame(width: min(CGFloat(progress) * geometry.size.width, geometry.size.width), height: 6)
                                .shadow(color: color.opacity(0.3), radius: 3, x: 0, y: 1)
                        }
                    }
                }
                .frame(height: 6)
                .padding(.top, 4)
            }
        }
        .padding(16)
        .background(
            ZStack {
                if showGradient {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    color.opacity(0.05),
                                    color.opacity(0.02),
                                    color.opacity(0.01),
                                    .clear
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(ColorTheme.backgroundSecondary)
                }

                RoundedRectangle(cornerRadius: 16)
                    .stroke(ColorTheme.backgroundTertiary, lineWidth: 1)
            }
        )
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 2)
    }
}


// MARK: - Previews
struct StatCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Single small preview (sizeThatFits)
            StatCard(
                icon: "clock.fill",
                value: "45m",
                label: "Active Time",
                progress: nil,
                color: ColorTheme.accentBlue
            )
            .frame(width: 160, height: 140)
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .previewDisplayName("Simple Card (sizeThatFits)")

            // Stacked examples (larger)
            ZStack {
                ColorTheme.backgroundPrimary.ignoresSafeArea()

                VStack(spacing: 20) {
                    StatCard(
                        icon: "flame.fill",
                        value: "1,234",
                        label: "Calories Burned",
                        progress: 0.65,
                        color: ColorTheme.accentRed,
                        secondaryText: "+125 from yesterday",
                        showGradient: true
                    )
                    .frame(height: 180)

                    StatCard(
                        icon: "figure.run",
                        value: "8,456",
                        label: "Daily Steps",
                        progress: 0.42,
                        color: ColorTheme.accentBlue,
                        secondaryText: "3,144 to goal"
                    )
                    .frame(height: 180)

                    StatCard(
                        icon: "drop.fill",
                        value: "2.1L",
                        label: "Water Intake"
                    )
                    .frame(height: 140)
                }
                .padding()
            }
            .preferredColorScheme(.dark)
            .previewDisplayName("With Progress & Gradient")
        }
    }
}
