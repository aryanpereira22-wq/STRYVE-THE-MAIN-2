import SwiftUI

/// A circular progress ring that displays multiple segments with different gradients.
/// Each segment represents a portion of the whole, with smooth animations on appear.
public struct RankProgressRing: View {
    // MARK: - Properties
    let segments: [Double]
    let gradients: [LinearGradient]
    let ringWidth: CGFloat
    let centerImageName: String
    let centerImageSize: CGFloat
    let showBackgroundRing: Bool
    let centerBackground: Color

    // MARK: - State
    @State private var animationProgress: [Double]
    @State private var isAnimating = false
    @State private var glowPulse = false

    // MARK: - Initialization
    public init(
        segments: [Double],
        gradients: [LinearGradient],
        ringWidth: CGFloat = 24,
        centerImageName: String = "rank_ruby",
        centerImageSize: CGFloat = 0.50,
        showBackgroundRing: Bool = true,
        centerBackground: Color = Color(white: 0.15)
    ) {
        self.segments = segments
        self.gradients = gradients
        self.ringWidth = ringWidth
        self.centerImageName = centerImageName
        self.centerImageSize = centerImageSize
        self.showBackgroundRing = showBackgroundRing
        self.centerBackground = centerBackground
        // initialize animationProgress with same length as segments
        self._animationProgress = State(initialValue: Array(repeating: 0, count: segments.count))
    }

    // MARK: - Body
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background ring
                if showBackgroundRing {
                    Circle()
                        .stroke(
                            ColorTheme.backgroundSecondary,
                            style: StrokeStyle(lineWidth: ringWidth, lineCap: .round)
                        )
                }

                // Segments
                ForEach(0..<segments.count, id: \.self) { index in
                    segmentView(at: index)
                }

                // Center circle background
                Circle()
                    .fill(centerBackground)
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.6)
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)

                // Center image with pink glow + subtle pulse
                Image(centerImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width * centerImageSize)
                    .shadow(color: Color.white.opacity(0.20), radius: 10, x: 0, y: 0)
                    .shadow(color: Color.pink.opacity(glowPulse ? 0.75 : 0.0), radius: glowPulse ? 24 : 0, x: 0, y: 0)
                    .scaleEffect(isAnimating ? (glowPulse ? 1.06 : 1.02) : 0.8)
                    .opacity(isAnimating ? 1.0 : 0.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear(perform: animateOnAppear)
    }

    // MARK: - Private Helpers
    @ViewBuilder
    private func segmentView(at index: Int) -> some View {
        let start = index > 0 ? segments[0..<index].reduce(0, +) : 0
        let end = start + (isAnimating ? animationProgress[index] : 0)

        let gradient = gradients.indices.contains(index)
            ? gradients[index]
            : LinearGradient(colors: [.clear], startPoint: .leading, endPoint: .trailing)

        Circle()
            .trim(from: start, to: end)
            .stroke(
                gradient,
                style: StrokeStyle(lineWidth: ringWidth, lineCap: .round, lineJoin: .round)
            )
            .rotationEffect(.degrees(-90))
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeOut(duration: 1.0).delay(Double(index) * 0.1), value: isAnimating)
    }

    private func animateOnAppear() {
        guard !isAnimating else { return }
        isAnimating = true

        for (index, _) in segments.enumerated() {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(Double(index) * 0.1)) {
                animationProgress[index] = segments[index]
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                glowPulse = true
            }
        }
    }
}

// MARK: - Preview Helpers
private struct RankProgressRingDemo: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Rank Progress")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(ColorTheme.primaryText)

                RankProgressRing(
                    segments: [0.5, 0.3, 0.2],
                    gradients: [
                        LinearGradient(colors: [Color.purple, Color.purple.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing),
                        LinearGradient(colors: [.teal, .teal.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing),
                        LinearGradient(colors: [Color.pink, Color.pink.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    ],
                    ringWidth: 20,
                    centerImageName: "star.fill",
                    centerImageSize: 0.25,
                    centerBackground: Color(red: 0.05, green: 0.05, blue: 0.05) // near-black gray
                )
                .frame(width: 220, height: 220)

                HStack(spacing: 20) {
                    legendItem(color: .purple, text: "Running")
                    legendItem(color: .teal, text: "Cycling")
                    legendItem(color: .pink, text: "Swimming")
                }
            }
            .padding()
        }
    }

    private func legendItem(color: Color, text: String) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)

            Text(text)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(ColorTheme.textSecondary)
        }
    }
}

struct RankProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        RankProgressRingDemo()
            .preferredColorScheme(.dark)
    }
}
