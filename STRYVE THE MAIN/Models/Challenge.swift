//
//  Challenge.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 10/08/2025.
//

import SwiftUI

/// Represents a fitness challenge that users can participate in
struct Challenge: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let type: ChallengeType
    let targetValue: Double
    let currentValue: Double
    let participants: Int
    let duration: Int
    let timeLeft: Int
    let isJoined: Bool
    let icon: String
    let colorHex: String
    
    /// Computed property to get Color from hex string
    var color: Color {
        Color(hex: colorHex)
    }
    
    /// Memberwise initializer
    init(id: Int, title: String, description: String, type: ChallengeType,
         targetValue: Double, currentValue: Double, participants: Int,
         duration: Int, timeLeft: Int, isJoined: Bool, icon: String, colorHex: String) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.targetValue = targetValue
        self.currentValue = currentValue
        self.participants = participants
        self.duration = duration
        self.timeLeft = timeLeft
        self.isJoined = isJoined
        self.icon = icon
        self.colorHex = colorHex
    }
    
    // MARK: - Computed Properties
    
    /// Progress value between 0.0 and 1.0
    var progress: Double {
        min(currentValue / targetValue, 1.0)
    }
    
    /// Formatted target value with appropriate units
    var targetValueFormatted: String {
        if type == .distance {
            return String(format: "%.1f km", targetValue)
        } else if type == .water {
            return "\(Int(targetValue))ml"
        } else {
            return "\(Int(targetValue))"
        }
    }
    
    /// Formatted current value with appropriate units
    var currentValueFormatted: String {
        if type == .distance {
            return String(format: "%.1f km", currentValue)
        } else if type == .water {
            return "\(Int(currentValue))ml"
        } else {
            return "\(Int(currentValue))"
        }
    }
}

/// Represents different types of fitness challenges
enum ChallengeType: String, Codable, CaseIterable {
    case step
    case distance
    case calories
    case activeMinutes
    case water
    
    /// The unit string for display purposes
    var unit: String {
        switch self {
        case .step: return "steps"
        case .distance: return "km"
        case .calories: return "cal"
        case .activeMinutes: return "min"
        case .water: return "ml"
        }
    }
}
