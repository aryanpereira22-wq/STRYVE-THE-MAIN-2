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
                VStack(spacing: 30) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Welcome back,")
                                .font(.title3)
                                .foregroundColor(.gray)
                            Text("Athlete")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
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
                    .padding(.vertical, 20)
                    
                    // Tracking buttons
                    HStack(spacing: 20) {
                        TrackingButton(icon: "figure.run", title: "Run", color: .blue)
                        TrackingButton(icon: "dumbbell.fill", title: "Weights", color: .green)
                        TrackingButton(icon: "heart.fill", title: "Heart", color: .red)
                    }
                    .padding(.horizontal)
                    
                    // Quest section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Today's Quests")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        // Quest rows
                        VStack(spacing: 15) {
                            ForEach(0..<2) { _ in
                                HStack(spacing: 15) {
                                    ForEach(0..<2) { _ in
                                        QuestCard()
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
    }
}

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
                            .stroke(LinearGradient(gradient: Gradient(colors: [color.opacity(0.7), color]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
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

struct QuestCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(white: 0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                )
                .frame(height: 100)
            
            VStack {
                Text("Daily Steps")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("5,000/10,000")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
