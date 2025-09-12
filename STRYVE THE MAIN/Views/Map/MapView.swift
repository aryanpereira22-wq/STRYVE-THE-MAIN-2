//
//  MapView.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/08/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    @State private var selectedTab = 0
    @State private var showFilters = false
    @State private var showNewActivity = false
    
    // Mock data
    let users: [MapUser] = [
        MapUser(id: 1, name: "You", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), isCurrentUser: true, steps: 8456, rank: 1),
        MapUser(id: 2, name: "Alex", coordinate: CLLocationCoordinate2D(latitude: 37.7759, longitude: -122.4184), isCurrentUser: false, steps: 7890, rank: 2),
        MapUser(id: 3, name: "Jordan", coordinate: CLLocationCoordinate2D(latitude: 37.7739, longitude: -122.4204), isCurrentUser: false, steps: 7210, rank: 3),
        MapUser(id: 4, name: "Taylor", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4174), isCurrentUser: false, steps: 6890, rank: 4),
        MapUser(id: 5, name: "Casey", coordinate: CLLocationCoordinate2D(latitude: 37.7769, longitude: -122.4194), isCurrentUser: false, steps: 6540, rank: 5)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Map View
            Map(position: $position) {
                UserAnnotation()
                
                ForEach(users) { user in
                    Annotation(user.name, coordinate: user.coordinate) {
                        MapUserPin(user: user)
                    }
                }
            }
            .mapControls {
                MapUserLocationButton()
            }
            .mapStyle(selectedTab == 0 ? .standard : .imagery(elevation: .realistic))
            
            // Top Controls
            VStack {
                HStack {
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(ColorTheme.primaryBlue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    // Map Type Selector
                    Picker("Map Type", selection: $selectedTab) {
                        Text("Map").tag(0)
                        Text("Satellite").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 180)
                    .padding(.trailing)
                }
                .padding(.top, 8)
                
                Spacer()
            }
            
            // Bottom Sheet
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    // Handle
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 5)
                        .padding(.top, 8)
                    
                    // Title
                    HStack {
                        Text("Nearby Activity")
                            .font(FontTheme.headlineMedium)
                        
                        Spacer()
                        
                        Button("See All") {}
                            .font(FontTheme.labelMedium)
                            .foregroundColor(ColorTheme.primaryBlue)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Leaderboard List
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(users) { user in
                                UserRankingCard(user: user)
                            }
                        }
                        .padding()
                    }
                    
                    // Start Activity Button
                    Button(action: { showNewActivity = true }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Start Activity")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(ColorTheme.primaryBlue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                    }
                }
                .background(ColorTheme.backgroundPrimary)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .shadow(radius: 10)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $showFilters) {
            FilterView()
        }
        .sheet(isPresented: $showNewActivity) {
            NewActivityView()
        }
    }
}

// MARK: - Subviews

struct MapUserPin: View {
    let user: MapUser
    
    var body: some View {
        ZStack {
            if user.isCurrentUser {
                // Current user pin
                ZStack {
                    Circle()
                        .fill(ColorTheme.primaryBlue.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .fill(ColorTheme.primaryBlue)
                        .frame(width: 40, height: 40)
                    
                    Text("YOU")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                }
            } else {
                // Other users
                ZStack {
                    Circle()
                        .fill(ColorTheme.accentRed.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .fill(ColorTheme.accentRed)
                        .frame(width: 36, height: 36)
                    
                    Text(user.name.prefix(1))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
                .overlay(
                    // Rank badge
                    ZStack {
                        Circle()
                            .fill(ColorTheme.backgroundPrimary)
                            .frame(width: 24, height: 24)
                        
                        Text("\(user.rank)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(ColorTheme.textPrimary)
                    }
                    .offset(x: 15, y: -15)
                )
            }
        }
    }
}

struct UserRankingCard: View {
    let user: MapUser
    
    var body: some View {
        VStack(spacing: 8) {
            // Rank
            if user.rank <= 3 {
                ZStack {
                    Circle()
                        .fill(rankColor)
                        .frame(width: 30, height: 30)
                    
                    Text("\(user.rank)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            } else {
                Text("\(user.rank)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(ColorTheme.textSecondary)
            }
            
            // Avatar
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(user.isCurrentUser ? ColorTheme.primaryBlue : Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text(user.name.prefix(1))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(user.isCurrentUser ? .white : ColorTheme.textPrimary)
                    )
                
                if user.isCurrentUser {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(ColorTheme.backgroundPrimary, lineWidth: 2)
                        )
                }
            }
            
            // Name
            Text(user.isCurrentUser ? "You" : user.name)
                .font(FontTheme.labelMedium)
                .foregroundColor(ColorTheme.textPrimary)
            
            // Steps
            Text("\(user.steps)")
                .font(FontTheme.labelSmall)
                .foregroundColor(ColorTheme.textSecondary)
            
            Text("steps")
                .font(FontTheme.caption)
                .foregroundColor(ColorTheme.textSecondary)
        }
        .padding()
        .background(user.isCurrentUser ? ColorTheme.primaryBlue.opacity(0.1) : ColorTheme.backgroundSecondary)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(user.isCurrentUser ? ColorTheme.primaryBlue : Color.clear, lineWidth: 1)
        )
    }
    
    private var rankColor: Color {
        switch user.rank {
        case 1: return ColorTheme.goldRank
        case 2: return ColorTheme.silverRank
        case 3: return ColorTheme.bronzeRank
        default: return Color.gray
        }
    }
}

// MARK: - Supporting Views

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedActivity = 0
    @State private var selectedDistance = 0
    @State private var selectedTime = 0
    
    let activities = ["All Activities", "Running", "Walking", "Cycling", "Workout"]
    let distances = ["Any Distance", "< 1 km", "1-5 km", "5-10 km", "> 10 km"]
    let times = ["Any Time", "Last Hour", "Today", "This Week"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Activity Type")) {
                    Picker("Activity", selection: $selectedActivity) {
                        ForEach(0..<activities.count, id: \.self) { index in
                            Text(activities[index]).tag(index)
                        }
                    }
                }
                
                Section(header: Text("Distance")) {
                    Picker("Distance", selection: $selectedDistance) {
                        ForEach(0..<distances.count, id: \.self) { index in
                            Text(distances[index]).tag(index)
                        }
                    }
                }
                
                Section(header: Text("Time")) {
                    Picker("Time", selection: $selectedTime) {
                        ForEach(0..<times.count, id: \.self) { index in
                            Text(times[index]).tag(index)
                        }
                    }
                }
                
                Section {
                    Button(action: applyFilters) {
                        Text("Apply Filters")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .padding()
                            .background(ColorTheme.primaryBlue)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("Filters")
            .navigationBarItems(trailing: Button("Reset") {
                resetFilters()
            })
        }
    }
    
    private func applyFilters() {
        // Apply filter logic here
        presentationMode.wrappedValue.dismiss()
    }
    
    private func resetFilters() {
        selectedActivity = 0
        selectedDistance = 0
        selectedTime = 0
    }
}

struct NewActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedActivity = 0
    @State private var isTracking = false
    
    let activities = ["Running", "Walking", "Cycling", "Swimming", "Workout"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if !isTracking {
                    // Activity Type Selection
                    VStack(spacing: 16) {
                        Text("Select Activity Type")
                            .font(FontTheme.headlineMedium)
                            .padding(.top)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(0..<activities.count, id: \.self) { index in
                                Button(action: { selectedActivity = index }) {
                                    VStack {
                                        Image(systemName: activityIcon(for: activities[index]))
                                            .font(.system(size: 30))
                                            .foregroundColor(selectedActivity == index ? .white : ColorTheme.primaryBlue)
                                            .frame(width: 70, height: 70)
                                            .background(selectedActivity == index ? ColorTheme.primaryBlue : ColorTheme.primaryBlue.opacity(0.1))
                                            .cornerRadius(12)
                                        
                                        Text(activities[index])
                                            .font(FontTheme.labelMedium)
                                            .foregroundColor(selectedActivity == index ? ColorTheme.primaryBlue : ColorTheme.textPrimary)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                    .background(ColorTheme.backgroundPrimary)
                    .cornerRadius(16)
                    .padding()
                    
                    Spacer()
                    
                    // Start Button
                    Button(action: { isTracking = true }) {
                        Text("Start Activity")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(ColorTheme.primaryBlue)
                            .cornerRadius(12)
                    }
                    .padding()
                    
                } else {
                    // Activity Tracking View
                    VStack(spacing: 20) {
                        // Timer and Stats
                        VStack(spacing: 8) {
                            Text("00:12:45")
                                .font(.system(size: 48, weight: .bold, design: .monospaced))
                                .foregroundColor(ColorTheme.textPrimary)
                            
                            HStack(spacing: 30) {
                                VStack {
                                    Text("1.25")
                                        .font(FontTheme.statsNumber)
                                    Text("km")
                                        .font(FontTheme.labelSmall)
                                }
                                
                                VStack {
                                    Text("8:15")
                                        .font(FontTheme.statsNumber)
                                    Text("min/km")
                                        .font(FontTheme.labelSmall)
                                }
                                
                                VStack {
                                    Text("124")
                                        .font(FontTheme.statsNumber)
                                    Text("bpm")
                                        .font(FontTheme.labelSmall)
                                }
                            }
                            .padding(.vertical)
                        }
                        
                        // Map Placeholder
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 200)
                            .overlay(
                                Text("Map View")
                                    .foregroundColor(.gray)
                            )
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        // Controls
                        HStack(spacing: 30) {
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "pause.fill")
                                        .font(.title2)
                                    Text("Pause")
                                        .font(FontTheme.labelMedium)
                                }
                                .frame(width: 80, height: 80)
                                .background(Color.orange.opacity(0.1))
                                .foregroundColor(.orange)
                                .clipShape(Circle())
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "stop.fill")
                                        .font(.title2)
                                    Text("Stop")
                                        .font(FontTheme.labelMedium)
                                }
                                .frame(width: 100, height: 100)
                                .background(Color.red.opacity(0.1))
                                .foregroundColor(.red)
                                .clipShape(Circle())
                            }
                            
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "ellipsis")
                                        .font(.title2)
                                    Text("More")
                                        .font(FontTheme.labelMedium)
                                }
                                .frame(width: 80, height: 80)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .clipShape(Circle())
                            }
                        }
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationTitle("New Activity")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func activityIcon(for activity: String) -> String {
        switch activity.lowercased() {
        case "running": return "figure.run"
        case "walking": return "figure.walk"
        case "cycling": return "bicycle"
        case "swimming": return "figure.pool.swim"
        default: return "figure.mixed.cardio"
        }
    }
}

// MARK: - Data Models

struct MapUser: Identifiable {
    let id: Int
    let name: String
    let coordinate: CLLocationCoordinate2D
    let isCurrentUser: Bool
    let steps: Int
    let rank: Int
}

// MARK: - Preview

#Preview {
    MapView()
}
