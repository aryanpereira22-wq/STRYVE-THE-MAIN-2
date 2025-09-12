import SwiftUI

/// A view that displays a horizontal scrollable list of quick action buttons
struct QuickActionsView: View {
    // MARK: - Properties
    
    /// The array of quick actions to display
    let actions: [QuickAction]
    
    /// Action handler for when a quick action is tapped
    var onActionTapped: ((QuickAction) -> Void)? = nil
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section header
            Text("Quick Actions")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(ColorTheme.primaryText)
                .padding(.horizontal, 20)
            
            // Horizontal scrollable list of quick actions
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Add spacing before first button
                    Spacer()
                        .frame(width: 4)
                    
                    // Quick action buttons
                    ForEach(actions) { action in
                        QuickActionButton(
                            icon: action.icon,
                            label: action.label,
                            color: action.color,
                            action: { onActionTapped?(action) }
                        )
                    }
                    
                    // Add spacing after last button
                    Spacer()
                        .frame(width: 4)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Quick Action Model

/// A model representing a quick action
struct QuickAction: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    let color: Color
    let type: ActionType
    
    enum ActionType {
        case logWorkout
        case logWater
        case logMeal
        case logSleep
        case custom(String)
    }
    
    static let defaultActions: [QuickAction] = [
        QuickAction(
            icon: "plus",
            label: "Log Workout",
            color: ColorTheme.accentBlue,
            type: .logWorkout
        ),
        QuickAction(
            icon: "drop.fill",
            label: "Water",
            color: ColorTheme.accentTeal,
            type: .logWater
        ),
        QuickAction(
            icon: "fork.knife",
            label: "Meal",
            color: ColorTheme.accentOrange,
            type: .logMeal
        ),
        QuickAction(
            icon: "bed.double.fill",
            label: "Sleep",
            color: ColorTheme.accentPurple,
            type: .logSleep
        )
    ]
}

// MARK: - Quick Action Button

/// A single quick action button
struct QuickActionButton: View {
    // MARK: - Properties
    
    /// The SF Symbol name for the icon
    let icon: String
    
    /// The label text to display below the icon
    let label: String
    
    /// The accent color for the button
    let color: Color
    
    /// The action to perform when the button is tapped
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                // Icon container
                ZStack {
                    // Background circle with gradient
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    color.opacity(0.2),
                                    color.opacity(0.1)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            color.opacity(0.5),
                                            color.opacity(0.2)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                    
                    // Icon
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(color)
                        .shadow(color: color.opacity(0.3), radius: 4, x: 0, y: 2)
                }
                .frame(width: 60, height: 60)
                
                // Label
                Text(label)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(ColorTheme.primaryText)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 80)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Button Style

/// A button style that scales down when pressed
private struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Previews

#Preview("Default Actions") {
    ZStack {
        ColorTheme.backgroundPrimary.ignoresSafeArea()
        
        QuickActionsView(
            actions: QuickAction.defaultActions,
            onActionTapped: { action in
                print("Quick action tapped: \(action.label)")
            }
        )
        .padding(.vertical)
    }
}

#Preview("Custom Actions") {
    ZStack {
        ColorTheme.backgroundPrimary.ignoresSafeArea()
        
        QuickActionsView(
            actions: [
                QuickAction(
                    icon: "figure.run",
                    label: "Morning Run",
                    color: .purple,
                    type: .logWorkout
                ),
                QuickAction(
                    icon: "figure.yoga",
                    label: "Yoga",
                    color: .pink,
                    type: .custom("yoga")
                ),
                QuickAction(
                    icon: "bicycle",
                    label: "Cycling",
                    color: .orange,
                    type: .custom("cycling")
                ),
                QuickAction(
                    icon: "figure.strengthtraining.traditional",
                    label: "Strength",
                    color: .blue,
                    type: .logWorkout
                )
            ]
        )
        .padding()
    }
}
