//
//  FitnessData.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 07/08/2025.
//

import Foundation

struct FitnessData: Identifiable, Codable {
    var id: UUID
    let date: Date
    var steps: Int
    var distance: Double // in kilometers
    var caloriesBurned: Int
    var activeMinutes: Int
    var waterIntake: Double // in liters
    var workoutSessions: [WorkoutSession]
    
    // Daily goals
    var stepGoal: Int
    var distanceGoal: Double
    var calorieGoal: Int
    var waterGoal: Double
    
    init(id: UUID = UUID(), 
         date: Date, 
         steps: Int, 
         distance: Double, 
         caloriesBurned: Int, 
         activeMinutes: Int, 
         waterIntake: Double, 
         workoutSessions: [WorkoutSession] = [],
         stepGoal: Int = 10000,
         distanceGoal: Double = 8.0,
         calorieGoal: Int = 2000,
         waterGoal: Double = 2.5) {
        self.id = id
        self.date = date
        self.steps = steps
        self.distance = distance
        self.caloriesBurned = caloriesBurned
        self.activeMinutes = activeMinutes
        self.waterIntake = waterIntake
        self.workoutSessions = workoutSessions
        self.stepGoal = stepGoal
        self.distanceGoal = distanceGoal
        self.calorieGoal = calorieGoal
        self.waterGoal = waterGoal
    }
    
    // Progress calculations
    var stepProgress: Double {
        min(Double(steps) / Double(stepGoal), 1.0)
    }
    
    var distanceProgress: Double {
        min(distance / distanceGoal, 1.0)
    }
    
    var calorieProgress: Double {
        min(Double(caloriesBurned) / Double(calorieGoal), 1.0)
    }
    
    var waterProgress: Double {
        min(waterIntake / waterGoal, 1.0)
    }
}

struct WorkoutSession: Identifiable, Codable {
    var id: UUID
    let type: WorkoutType
    let startTime: Date
    let endTime: Date
    let duration: TimeInterval
    let caloriesBurned: Int
    let distance: Double?
    let averageHeartRate: Int?
    let maxHeartRate: Int?
    
    init(id: UUID = UUID(),
         type: WorkoutType,
         startTime: Date,
         endTime: Date,
         duration: TimeInterval,
         caloriesBurned: Int,
         distance: Double? = nil,
         averageHeartRate: Int? = nil,
         maxHeartRate: Int? = nil) {
        self.id = id
        self.type = type
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
        self.caloriesBurned = caloriesBurned
        self.distance = distance
        self.averageHeartRate = averageHeartRate
        self.maxHeartRate = maxHeartRate
    }
    
    var durationFormatted: String {
        let minutes = Int(duration / 60)
        let seconds = Int(duration.truncatingRemainder(dividingBy: 60))
        return String(format: "%d:%02d", minutes, seconds)
    }
}

enum WorkoutType: String, Codable, CaseIterable {
    case running = "Running"
    case walking = "Walking"
    case cycling = "Cycling"
    case swimming = "Swimming"
    case yoga = "Yoga"
    case strength = "Strength Training"
    case hiit = "HIIT"
    case other = "Other"
    
    var iconName: String {
        switch self {
        case .running: return "figure.run"
        case .walking: return "figure.walk"
        case .cycling: return "bicycle"
        case .swimming: return "figure.pool.swim"
        case .yoga: return "figure.yoga"
        case .strength: return "dumbbell"
        case .hiit: return "flame"
        case .other: return "figure.mixed.cardio"
        }
    }
    
    var color: String {
        switch self {
        case .running: return "red"
        case .walking: return "green"
        case .cycling: return "blue"
        case .swimming: return "cyan"
        case .yoga: return "purple"
        case .strength: return "orange"
        case .hiit: return "pink"
        case .other: return "gray"
        }
    }
}
