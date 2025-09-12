//
//  ChallengesView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//

import SwiftUI

struct ChallengesView: View {
    @State private var selectedTab = 0
    @State private var showCreateChallenge = false
    
    // Mock data
    let activeChallenges = [
        Challenge(id: 1, 
                 title: "10K Steps Daily", 
                 description: "Reach 10,000 steps every day this week", 
                 type: .step, 
                 targetValue: 10000, 
                 currentValue: 6500, 
                 participants: 24, 
                 duration: 7, 
                 timeLeft: 3,
                 isJoined: true,
                 icon: "figure.walk",
                 colorHex: "00FF00"), // Green
        
        Challenge(id: 2, 
                 title: "Hydration Master", 
                 description: "Drink 2L of water daily", 
                 type: .water, 
                 targetValue: 2000, 
                 currentValue: 1200, 
                 participants: 15, 
                 duration: 7, 
                 timeLeft: 5,
                 isJoined: true,
                 icon: "drop.fill",
                 colorHex: "0000FF") // Blue
    ]
    
    let availableChallenges = [
        Challenge(id: 3, 
                 title: "Morning Runner", 
                 description: "Run 5km before 9 AM", 
                 type: .distance, 
                 targetValue: 5, 
                 currentValue: 0, 
                 participants: 8, 
                 duration: 7, 
                 timeLeft: 7,
                 isJoined: false,
                 icon: "sunrise.fill",
                 colorHex: "FFA500"), // Orange
        
        Challenge(id: 4, 
                 title: "Weekend Warrior", 
                 description: "Burn 1000 calories over the weekend", 
                 type: .calories, 
                 targetValue: 1000, 
                 currentValue: 0, 
                 participants: 12, 
                 duration: 2, 
                 timeLeft: 2,
                 isJoined: false,
                 icon: "flame.fill",
                 colorHex: "FF0000") // Red
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Segmented Control
                Picker("Challenge Type", selection: $selectedTab) {
                    Text("Active").tag(0)
                    Text("Available").tag(1)
                    Text("Completed").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Challenges List
                ScrollView {
                    VStack(spacing: 16) {
                        if selectedTab == 0 {
                            // Active Challenges
                            if activeChallenges.isEmpty {
                                emptyStateView("No Active Challenges", 
                                             message: "Join a challenge to get started!", 
                                             icon: "trophy")
                            } else {
                                ForEach(activeChallenges) { challenge in
                                    ChallengeCard(challenge: challenge) {
                                        // Handle view progress action
                                        print("View progress for \(challenge.title)")
                                    }
                                }
                            }
                        } else if selectedTab == 1 {
                            // Available Challenges
                            if availableChallenges.isEmpty {
                                emptyStateView("No Available Challenges", 
                                             message: "Check back later for new challenges!", 
                                             icon: "hourglass")
                            } else {
                                ForEach(availableChallenges) { challenge in
                                    ChallengeCard(challenge: challenge) {
                                        // Handle join challenge action
                                        print("Join challenge: \(challenge.title)")
                                    }
                                }
                            }
                        } else {
                            // Completed Challenges
                            emptyStateView("No Completed Challenges", 
                                         message: "Complete challenges to see them here!", 
                                         icon: "checkmark.seal")
                        }
                    }
                    .padding()
                }
            }
            .background(ColorTheme.backgroundPrimary)
            .navigationTitle("Challenges")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showCreateChallenge = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreateChallenge) {
                CreateChallengeView()
            }
        }
    }
    
    private func emptyStateView(_ title: String, message: String, icon: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(ColorTheme.primaryBlue.opacity(0.5))
            
            Text(title)
                .font(FontTheme.headlineMedium)
                .foregroundColor(ColorTheme.primaryText)
            
            Text(message)
                .font(FontTheme.bodyMedium)
                .foregroundColor(ColorTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.top, 100)
    }
}

// MARK: - Subviews

struct CreateChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var challengeTitle = ""
    @State private var challengeDescription = ""
    @State private var selectedType = 0
    @State private var targetValue = ""
    @State private var duration = 7
    @State private var isPublic = true
    
    let challengeTypes = ["Steps", "Distance (km)", "Calories", "Active Minutes", "Water (ml)"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("CHALLENGE DETAILS")) {
                    TextField("Challenge Title", text: $challengeTitle)
                    
                    TextField("Description (optional)", text: $challengeDescription)
                    
                    Picker("Type", selection: $selectedType) {
                        ForEach(0..<challengeTypes.count, id: \.self) {
                            Text(challengeTypes[$0])
                        }
                    }
                    
                    TextField("Target Value", text: $targetValue)
                        .keyboardType(.numberPad)
                    
                    Stepper(value: $duration, in: 1...30) {
                        Text("\(duration) \(duration == 1 ? "Day" : "Days")")
                    }
                    
                    Toggle("Public Challenge", isOn: $isPublic)
                }
                
                Section {
                    Button(action: createChallenge) {
                        Text("Create Challenge")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .padding()
                            .background(ColorTheme.primaryBlue)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(challengeTitle.isEmpty || targetValue.isEmpty)
                }
            }
            .navigationTitle("New Challenge")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Create") {
                    createChallenge()
                }
                .disabled(challengeTitle.isEmpty || targetValue.isEmpty)
            )
        }
    }
    
    private func createChallenge() {
        // Create challenge logic here
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Data Models
// MARK: - Preview

#Preview {
    ChallengesView()
}
