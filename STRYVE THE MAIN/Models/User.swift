//
//  User.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 07/08/2025.
//

import Foundation
import CoreLocation

struct User: Identifiable, Codable {
    let id = UUID()
    var username: String
    var email: String
    var profileImageURL: String?
    var level: Int
    var xp: Int
    var rank: Int
    var totalSteps: Int
    var totalDistance: Double // in kilometers
    var totalCaloriesBurned: Int
    var streakDays: Int
    var location: UserLocation?
    var badges: [Badge]
    var achievements: [Achievement]
    var joinDate: Date
    
    // Computed properties
    var xpToNextLevel: Int {
        let nextLevelXP = (level + 1) * 1000
        return nextLevelXP - xp
    }
    
    var levelProgress: Double {
        let currentLevelXP = level * 1000
        let nextLevelXP = (level + 1) * 1000
        let progressXP = xp - currentLevelXP
        return Double(progressXP) / Double(nextLevelXP - currentLevelXP)
    }
}

struct UserLocation: Codable {
    let latitude: Double
    let longitude: Double
    let city: String?
    let country: String?
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Badge: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let iconName: String
    let rarity: BadgeRarity
    let earnedDate: Date
}

enum BadgeRarity: String, Codable, CaseIterable {
    case common = "Common"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    
    var color: String {
        switch self {
        case .common: return "gray"
        case .rare: return "blue"
        case .epic: return "purple"
        case .legendary: return "gold"
        }
    }
}

struct Achievement: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let iconName: String
    let xpReward: Int
    let isCompleted: Bool
    let progress: Double // 0.0 to 1.0
    let completedDate: Date?
}
