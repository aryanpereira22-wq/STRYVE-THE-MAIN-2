//
//  HomeView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//  Option B: Premium Glassmorphism + Neon UI
//

import SwiftUI

struct HomeView: View {
    // MARK: - State
    @State private var showPassport: Bool = false
    @State private var selectedTab: String = "All"
    @State private var activeNav: Int = 0
    @State private var progress: Double = 0.75
    private let tabs = ["All", "Lower", "Upper", "Cardio"]
    private let userName = "James" // change as needed
    
    var body: some View {
        ZStack {
            // Background - deep gradient + vignette
            LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 6/255, green: 6/255, blue: 10/255, opacity: 1),
                                                       Color(.sRGB, red: 12/255, green: 8/255, blue: 18/255, opacity: 1)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
                    RadialGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.6)]),
                                   center: .center, startRadius: 200, endRadius: 700)
                )
            
            VStack(spacing: 18) {
                // MARK: Header
                HStack {
                    HStack(spacing: 12) {
                        // profile circle opens passport
                        Button(action: { showPassport.toggle() }) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(colors: [Color.white.opacity(0.08), Color.white.opacity(0.02)],
                                                         startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                                    )
                                    .shadow(color: Color.purple.opacity(0.12), radius: 6, x: 0, y: 4)
                                
                                Image(systemName: "person.fill")
                                    .font(.system(size: 22))
                                    .foregroundStyle(LinearGradient(colors: [Color.white.opacity(0.95), Color.white.opacity(0.8)],
                                                                    startPoint: .top, endPoint: .bottom))
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Hi \(userName)")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.white)
                            Text("Welcome back — level up your grind")
                                .font(.footnote)
                                .foregroundColor(Color.white.opacity(0.65))
                        }
                    }
                    
                    Spacer()
                    
                    // Rank card small pill
                    RankPillView()
                }
                .padding(.horizontal)
                .padding(.top, 18)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // MARK: Featured Progress Card (glass + neon)
                        FeaturedProgressCard(progress: $progress)
                            .padding(.horizontal)
                        
                        // MARK: Rank large card
                        RankCardView(rankImageName: "rank_ruby", rankName: "Ruby", rankSubtitle: "Current Rank")
                            .padding(.horizontal)
                        
                        // MARK: Tabs
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(tabs, id: \.self) { tab in
                                    TabItem(title: tab, isSelected: tab == selectedTab)
                                        .onTapGesture { withAnimation(.spring()) { selectedTab = tab } }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // MARK: Workout Cards
                        VStack(spacing: 0) {
                            NeonWorkoutCard(title: "Lower body workout",
                                            subtitle: "Cardio · 5 exercises\nGlutes / Squats / Hamstrings",
                                            time: "38 mins",
                                            gradientColors: [Color.purple.opacity(0.85), Color.blue.opacity(0.6)],
                                            imageSystem: "figure.squat")
                            
                            NeonWorkoutCard(title: "Upper body workout",
                                            subtitle: "Strength · 4 exercises\nArms / Chest / Shoulders",
                                            time: "29 mins",
                                            gradientColors: [Color.blue.opacity(0.85), Color.cyan.opacity(0.55)],
                                            imageSystem: "figure.strengthtraining.traditional")
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 6)
                }
                
                
            }
            .sheet(isPresented: $showPassport) {
                AthletePassportView(isPresented: $showPassport, userName: userName, xpProgress: progress)
            }
        }
    }
}

// MARK: - Rank Pill (header)
struct RankPillView: View {
    var body: some View {
        HStack(spacing: 8) {
            Image("rank_ruby")
                .resizable()
                .renderingMode(.original)
                .frame(width: 34, height: 34)
                .clipShape(Circle())
                .shadow(color: Color.red.opacity(0.35), radius: 6, x: 0, y: 3)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Ruby")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.white)
                Text("Rank")
                    .font(.caption2)
                    .foregroundColor(Color.white.opacity(0.6))
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial.opacity(0.18))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
    }
}

// MARK: - Featured Progress Card
struct FeaturedProgressCard: View {
    @Binding var progress: Double
    
    var body: some View {
        ZStack {
            // Glass base
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(hex: "#ff00ee").opacity(100),
                                    Color(hex: "#1400ab").opacity(100)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )


                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(Color.white.opacity(0.04), lineWidth: 1)
                )
                .shadow(color: Color.green.opacity(0.12), radius: 16, x: 0, y: 12)
                .frame(height: 150)
            
            HStack {
                // Left text block
                VStack(alignment: .leading, spacing: 8) {
                    Text("Progress")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Text("Lower Body")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.white)
                    
                    Text("Cardio 18 mins")
                        .font(.footnote)
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    HStack(spacing: 8) {
                        Label {
                            Text("538 Calories")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(.white)
                        } icon: {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(Color.orange)
                        }
                        .padding(.top, 4)
                    }
                }
                .padding(.leading, 20)
                
                Spacer()
                
                // Right circular progress
                ZStack {
                    Circle()
                        .trim(from: 0, to: CGFloat(progress))
                        .stroke(AngularGradient(colors: [Color.purple, Color.green, Color.blue],
                                               center: .center, startAngle: .degrees(-90), endAngle: .degrees(270)),
                                style: StrokeStyle(lineWidth: 12, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 88, height: 88)
                        .shadow(color: Color.purple.opacity(0.18), radius: 8, x: 0, y: 6)
                    
                    VStack {
                        Text("\(Int(progress * 100))%")
                            .font(.headline.weight(.bold))
                            .foregroundColor(.white)
                        Text("Daily")
                            .font(.caption2)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                }
                .padding(.trailing, 18)
            }
        }
        .overlay(
            // small icon decorative
            Image(systemName: "figure.strengthtraining.traditional")
                .font(.system(size: 46))
                .foregroundColor(Color.white.opacity(0.45))
                .offset(x: 100, y: -30)
        )
        .onTapGesture {
            // subtle tap pulse
            withAnimation(.spring(response: 0.45, dampingFraction: 0.7)) {
                // could navigate to workout detail
            }
        }
    }
}

// MARK: - Rank Card
struct RankCardView: View {
    let rankImageName: String
    let rankName: String
    let rankSubtitle: String
    
    @State private var glow = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(LinearGradient(colors: [Color.black.opacity(0.25), Color.white.opacity(0.02)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                .background(.ultraThinMaterial.opacity(0.12))
                .frame(height: 110)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white.opacity(0.04), lineWidth: 1)
                )
                .shadow(color: Color.red.opacity(0.18), radius: glow ? 30 : 12, x: 0, y: 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Your Rank")
                        .font(.footnote)
                        .foregroundColor(Color.white.opacity(0.7))
                    Text(rankName)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.white)
                    Text(rankSubtitle)
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.65))
                }
                Spacer()
                
                Image(rankImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 82, height: 82)
                    .shadow(color: Color.red.opacity(0.4), radius: 12, x: 0, y: 6)
                    .scaleEffect(glow ? 1.02 : 1.0)
            }
            .padding(.horizontal, 18)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                glow.toggle()
            }
        }
    }
}

// MARK: - Tab Item
struct TabItem: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.subheadline.weight(.semibold))
            .foregroundColor(isSelected ? Color.black : Color.white.opacity(0.9))
            .padding(.vertical, 9)
            .padding(.horizontal, 18)
            .background(
                Group {
                    if isSelected {
                        Capsule()
                            .fill(LinearGradient(colors: [Color.white, Color.white.opacity(0.85)], startPoint: .top, endPoint: .bottom))
                            .shadow(color: Color.white.opacity(0.06), radius: 6, x: 0, y: 6)
                    } else {
                        Capsule()
                            .fill(Color.white.opacity(0.03))
                    }
                }
            )
    }
}

// MARK: - Neon Workout Card
struct NeonWorkoutCard: View {
    let title: String
    let subtitle: String
    let time: String
    let gradientColors: [Color]
    let imageSystem: String
    
    @State private var hovered: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    LinearGradient(gradient: Gradient(colors: gradientColors),
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                        .opacity(0.55)
                )
                .frame(height: 130)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.white.opacity(0.03), lineWidth: 1)
                )
                .shadow(color: (gradientColors.last ?? Color.blue).opacity(0.2), radius: hovered ? 20 : 8, x: 0, y: 10)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.85))
                    Spacer()
                    Text(time)
                        .font(.caption.weight(.semibold))
                        .padding(.vertical, 1)
                        .padding(.horizontal, 12)
                        .background(Color.black.opacity(0.25))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: imageSystem)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundColor(Color.white.opacity(0.95))
                    .padding(.trailing, 18)
            }
            .padding(18)
        }
        .scaleEffect(hovered ? 1.01 : 1.0)
        .onTapGesture {
            // animate tap
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                hovered.toggle()
            }
            // navigate to workout detail in your app
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation { hovered = false }
            }
        }
    }
}

// MARK: - Athlete Passport (sheet)
struct AthletePassportView: View {
    @Binding var isPresented: Bool
    let userName: String
    let xpProgress: Double
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(.sRGB, red: 10/255, green: 8/255, blue: 20/255, opacity: 1),
                                                           Color(.sRGB, red: 18/255, green: 12/255, blue: 30/255, opacity: 1)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack {
                        Image("rank_ruby")
                            .resizable()
                            .frame(width: 86, height: 86)
                            .clipShape(Circle())
                            .shadow(color: Color.red.opacity(0.4), radius: 10, x: 0, y: 6)
                        
                        VStack(alignment: .leading) {
                            Text(userName)
                                .font(.title2.weight(.bold))
                                .foregroundColor(.white)
                            Text("Ruby • Athlete")
                                .font(.subheadline)
                                .foregroundColor(Color.white.opacity(0.75))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // XP progress
                    VStack(alignment: .leading, spacing: 8) {
                        Text("XP Progress")
                            .foregroundColor(Color.white.opacity(0.8))
                            .font(.callout.weight(.semibold))
                        
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.white.opacity(0.08))
                                .frame(height: 18)
                            Capsule()
                                .fill(LinearGradient(colors: [Color.purple, Color.red], startPoint: .leading, endPoint: .trailing))
                                .frame(width: CGFloat(max(50, xpProgress * 280)), height: 18)
                                .animation(.easeInOut, value: xpProgress)
                        }
                        HStack {
                            Text("\(Int(xpProgress * 100))% to next rank")
                                .foregroundColor(Color.white.opacity(0.75))
                                .font(.caption)
                            Spacer()
                            Text("XP: \(Int(xpProgress * 1200))/1200")
                                .foregroundColor(Color.white.opacity(0.6))
                                .font(.caption2)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Badges / Stats
                    VStack(spacing: 12) {
                        HStack(spacing: 18) {
                            PassportStat(title: "Streak", value: "12d", systemImage: "flame.fill")
                            PassportStat(title: "Badges", value: "8", systemImage: "rosette")
                            PassportStat(title: "Workouts", value: "142", systemImage: "bolt.fill")
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: { isPresented = false }) {
                        Text("Close passport")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(14)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 24)
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
        }
    }
}

struct PassportStat: View {
    let title: String
    let value: String
    let systemImage: String
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: 58, height: 58)
                Image(systemName: systemImage)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Bottom Glass Navigation
struct BottomGlassNav: View {
    @Binding var selected: Int
    let icons = ["house.fill", "chart.bar.fill", "rosette", "person.crop.circle.fill"]
    
    var body: some View {
        HStack {
            ForEach(0..<icons.count, id: \.self) { i in
                Button(action: {
                    withAnimation(.spring()) { selected = i }
                }) {
                    ZStack {
                        if selected == i {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(colors: [Color.white.opacity(0.12), Color.white.opacity(0.04)],
                                                     startPoint: .top, endPoint: .bottom))
                                .frame(width: 56, height: 46)
                        }
                        
                        Image(systemName: icons[i])
                            .font(.system(size: 20))
                            .foregroundColor(selected == i ? Color.white : Color.white.opacity(0.6))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Spacer(minLength: 6)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(.ultraThinMaterial.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.03), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
