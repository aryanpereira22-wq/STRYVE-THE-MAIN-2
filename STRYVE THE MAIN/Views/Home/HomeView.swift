//
//  HomeView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//

import SwiftUI

struct HomeView: View {
    // Sample data
    @State private var progress: Double = 0.75
    private let ringColors: [Color] = [.purple, .blue, .green]
    
    var body: some View {
        ZStack {
            // Dark background
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 40) {
                    
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome Back,")
                                .font(.title3)
                                .foregroundColor(.gray)
                            
                            Text("Athlete")
                                .font(.system(size: 30, weight: .bold)) // smaller so no overlap
                                .foregroundColor(.white)
                        }
                        .padding(.top, 20) // moved header lower
                        
                        Spacer()
                        
                        // Profile button
                        Button(action: {}) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Progress Ring
                    ZStack {
                        // Background circle
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                            .frame(width: 250, height: 250)
                        
                        // Progress ring
                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: ringColors),
                                    center: .center,
                                    startAngle: .degrees(-90),
                                    endAngle: .degrees(270)
                                ),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round)
                            )
                            .frame(width: 250, height: 250)
                            .rotationEffect(.degrees(-90))
                        
                        // Center content
                        VStack {
                            Text("75%")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.white)
                            Text("Daily Goal")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 10)
                    
                    // Tracking buttons
                    HStack {
                        Spacer()
                        TrackingButton(icon: "figure.run", title: "Run", color: .blue)
                        Spacer()
                        TrackingButton(icon: "dumbbell.fill", title: "Weights", color: .green)
                        Spacer()
                        TrackingButton(icon: "heart.fill", title: "Heart", color: .red)
                        Spacer()
                    }
                    
                    // Today’s Quests → Number Rings
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Today's Quests")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            NumberRing(value: "5.3", title: "KM", color: .purple)
                            Spacer()
                            NumberRing(value: "35", title: "MIN", color: .blue)
                            Spacer()
                            NumberRing(value: "110", title: "BPM", color: .green)
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
            }
        }
    }
}

// MARK: - Tracking Button
struct TrackingButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 70, height: 70)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [color.opacity(0.7), color]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 10 // 5x thicker
                            )
                    )
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Number Ring
struct NumberRing: View {
    let value: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 70, height: 70)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [color.opacity(0.7), color]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 10 // thick stroke
                            )
                    )
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    HomeView()
}
