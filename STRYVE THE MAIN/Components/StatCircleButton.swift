import SwiftUI

/// A circular button with an icon and progress ring, typically used for displaying stats.
public struct StatCircleButton: View {
    // MARK: - Properties
    
    /// The name of the image asset to display (mutually exclusive with systemName)
    let imageName: String?
    
    /// The name of the SF Symbol to display (mutually exclusive with imageName)
    let systemName: String?
    
    /// The stat value to display (optional)
    let value: String?
    
    /// The label to display below the value (optional)
    let label: String?
    
    /// The progress value (0.0 to 1.0)
    let progress: Double
    
    /// The gradient for the progress ring
    let gradient: LinearGradient
    
    /// The colors used for the gradient (needed for shadow effect)
    private let gradientColors: [Color]
    
    /// The diameter of the button
    let diameter: CGFloat
    
    /// The action to perform when the button is tapped
    let action: () -> Void
    
    // MARK: - State
    
    @State private var isPressed = false
    @State private var animatedProgress: Double = 0
    @State private var isAnimating = false
    
    // MARK: - Initialization
    
    public init(
        imageName: String? = nil,
        systemName: String? = nil,
        value: String? = nil,
        label: String? = nil,
        progress: Double = 1.0,
        gradient: LinearGradient,
        gradientColors: [Color],
        diameter: CGFloat = 80,
        action: @escaping () -> Void = {}
    ) {
        self.imageName = imageName
        self.systemName = systemName
        self.value = value
        self.label = label
        self.progress = max(0, min(1, progress)) // Clamp between 0 and 1
        self.gradient = gradient
        self.gradientColors = gradientColors
        self.diameter = diameter
        self.action = action
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Background circle
                Circle()
                    .fill(ColorTheme.backgroundTertiary)
                    .frame(width: diameter, height: diameter)
                
                // Progress ring background
                Circle()
                    .stroke(
                        ColorTheme.backgroundSecondary,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: diameter, height: diameter)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(
                        gradient,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: diameter, height: diameter)
                    .rotationEffect(.degrees(-90)) // Start from top
                    .shadow(color: gradientColors.first?.opacity(0.3) ?? .clear, radius: 5, x: 0, y: 3)
                
                // Icon or value
                if let value = value {
                    Text(value)
                        .font(.system(size: diameter * 0.35, weight: .bold))
                        .foregroundColor(ColorTheme.textPrimary)
                } else {
                    Group {
                        if let imageName = imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                        } else if let systemName = systemName {
                            Image(systemName: systemName)
                                .font(.system(size: diameter * 0.35, weight: .bold))
                        } else {
                            // Fallback in case neither is provided
                            Image(systemName: "questionmark")
                                .font(.system(size: diameter * 0.35, weight: .bold))
                        }
                    }
                    .foregroundColor(gradientColors.first ?? ColorTheme.textPrimary)
                    .frame(width: diameter * 0.5, height: diameter * 0.5)
                }
            }
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .onTapGesture(perform: handleTap)
            .onAppear(perform: animateOnAppear)
            .onChange(of: progress) { _, newValue in
                withAnimation(.easeOut(duration: 0.8)) {
                    animatedProgress = newValue
                }
            }
            
            // Label (if provided)
            if let label = label {
                Text(label.uppercased())
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(ColorTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
            }
        }
        .frame(width: diameter + 20)
    }
    
    // MARK: - Private Methods
    
    private func handleTap() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
            action()
        }
    }
    
    private func animateOnAppear() {
        guard !isAnimating else { return }
        isAnimating = true
        
        // Initial state
        animatedProgress = 0
        
        // Animate progress with a slight delay for a more polished feel
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeOut(duration: 1.0)) {
                animatedProgress = progress
            }
        }
    }
}

// MARK: - Preview Helpers

private struct StatCircleButtonDemo: View {
    var body: some View {
        ZStack {
            ColorTheme.backgroundPrimary.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Top row - Icon buttons
                HStack(spacing: 25) {
                    // Running stat with SF Symbol
                    StatCircleButton(
                        systemName: "figure.run",
                        progress: 0.75,
                        gradient: LinearGradient(
                            colors: [ColorTheme.solidBlue, ColorTheme.primaryBlue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        gradientColors: [ColorTheme.solidBlue, ColorTheme.primaryBlue],
                        diameter: 70
                    ) {
                        print("Running stat tapped")
                    }
                    
                    // Weights stat with SF Symbol
                    StatCircleButton(
                        systemName: "dumbbell.fill",
                        progress: 0.5,
                        gradient: LinearGradient(
                            colors: [ColorTheme.solidTeal, ColorTheme.accentTeal],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        gradientColors: [ColorTheme.solidTeal, ColorTheme.accentTeal],
                        diameter: 70
                    ) {
                        print("Weights stat tapped")
                    }
                    
                    // Heart rate stat with SF Symbol and value
                    StatCircleButton(
                        systemName: "heart.fill",
                        value: "72",
                        label: "BPM",
                        progress: 0.9,
                        gradient: LinearGradient(
                            colors: [ColorTheme.solidPink, ColorTheme.accentPink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        gradientColors: [ColorTheme.solidPink, ColorTheme.accentPink],
                        diameter: 90
                    ) {
                        print("Heart rate tapped")
                    }
                }
                
                // Bottom row - More examples
                HStack(spacing: 25) {
                    // Steps stat with value and label
                    StatCircleButton(
                        value: "8,742",
                        label: "STEPS",
                        progress: 0.65,
                        gradient: LinearGradient(
                            colors: [ColorTheme.solidPurple, ColorTheme.accentPurple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        gradientColors: [ColorTheme.solidPurple, ColorTheme.accentPurple],
                        diameter: 80
                    ) {
                        print("Steps tapped")
                    }
                    
                    // Custom image button
                    StatCircleButton(
                        imageName: "custom_icon",
                        label: "CUSTOM",
                        progress: 0.3,
                        gradient: LinearGradient(
                            colors: [ColorTheme.solidOrange, ColorTheme.accentOrange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        gradientColors: [ColorTheme.solidOrange, ColorTheme.accentOrange],
                        diameter: 70
                    ) {
                        print("Custom button tapped")
                    }
                }
            }
        }
    }
}

// MARK: - Previews

#Preview("Stat Circle Buttons") {
    StatCircleButtonDemo()
}

#Preview("Single Stat Circle") {
    ZStack {
        ColorTheme.backgroundPrimary.ignoresSafeArea()
        StatCircleButton(
            systemName: "figure.run",
            value: "5K",
            label: "RUN",
            progress: 0.75,
            gradient: LinearGradient(
                colors: [ColorTheme.primaryBlue, ColorTheme.accentTeal],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            gradientColors: [ColorTheme.primaryBlue, ColorTheme.accentTeal],
            diameter: 120
        ) {
            print("Run stat tapped")
        }
    }
}
