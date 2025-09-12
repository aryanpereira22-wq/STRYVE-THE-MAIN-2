//
//  ColorTheme.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 07/08/2025.
//

import SwiftUI

/// Centralized color theme for the app
public enum ColorTheme {
    // MARK: - Base Colors
    
    // Background Colors
    public static let backgroundPrimary = Color(hex: "0D0D0D")  // Dark background
    public static let backgroundSecondary = Color(hex: "1A1A1A")  // Slightly lighter than primary
    public static let backgroundTertiary = Color(hex: "262626")  // For elevated UI elements
    
    // Text Colors
    public static let primaryText = Color(hex: "EAEAEA")  // Main text color
    public static let textPrimary = primaryText  // Alias for compatibility
    public static let textSecondary = Color(hex: "A0A0A0")  // Secondary text
    public static let textTertiary = Color(hex: "666666")  // Disabled/tertiary text
    
    // Primary Accents
    public static let primaryBlue = Color(hex: "7BDFF6")  // Main brand blue
    public static let accentBlue = Color(hex: "4AC8FF")   // Brighter blue for accents
    public static let solidBlue = Color(hex: "1E88E5")    // Deeper blue for text/icons
    
    // Status Colors
    public static let success = Color(hex: "4FD6BE")     // Success/positive actions
    public static let warning = Color(hex: "FFB86C")     // Warning/attention needed
    public static let error = Color(hex: "FF6B6B")       // Error/destructive actions
    public static let info = Color(hex: "82AAFF")        // Informational messages
    
    // Accent Colors
    public static let accentRed = Color(hex: "FF6B6B")   // For errors/important actions
    public static let accentTeal = Color(hex: "5EE6D2")  // For success/confirmation
    public static let accentOrange = Color(hex: "FFA98F") // For warnings
    public static let accentPurple = Color(hex: "9C27B0") // For premium/royal features
    public static let accentPink = Color(hex: "E91E63")  // For highlights
    public static let accentGreen = Color(hex: "4CAF50") // For success states
    
    // Solid Colors (for text/icons)
    public static let solidRed = Color(hex: "F44336")
    public static let solidGreen = Color(hex: "2E7D32")
    public static let solidOrange = Color(hex: "EF6C00")
    public static let solidPurple = Color(hex: "6A1B9A")
    public static let solidPink = Color(hex: "AD1457")
    public static let solidTeal = Color(hex: "00897B")
    
    // MARK: - Gradients
    
    // Gradient Color Arrays (for LinearGradient)
    public static let neonGradientA: [Color] = [Color(hex: "C694FF"), Color(hex: "7BDFF6")]  // Purple to blue
    public static let neonGradientB: [Color] = [Color(hex: "FFB3E1"), Color(hex: "8EFFC1")]  // Pink to mint
    public static let neonGradientC: [Color] = [Color(hex: "FF9A9E"), Color(hex: "FAD0C4")]  // Coral to peach
    
    // Predefined Gradients
    public static let primaryGradient = LinearGradient(
        colors: neonGradientA,
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let secondaryGradient = LinearGradient(
        colors: neonGradientB,
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let ringGradient = LinearGradient(
        colors: neonGradientA,
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // MARK: - UI Elements
    
    // Buttons
    public static let primaryButton = LinearGradient(
        colors: [Color(hex: "82AAFF"), Color(hex: "C792EA")],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    // Cards & Containers
    public static let cardBackground = Color(hex: "1A1A1A").opacity(0.7)
    public static let cardBorder = Color.white.opacity(0.1)
    public static let divider = Color.white.opacity(0.1)
    
    // Shadows
    public static let shadow = Color.black.opacity(0.3)
    public static let shadowColor = Color.black.opacity(0.2)
    public static let lightShadowColor = Color.white.opacity(0.1)
    
    // MARK: - Special Colors
    
    // Social Colors
    public static let facebookBlue = Color(hex: "1877F2")
    public static let googleRed = Color(hex: "DB4437")
    public static let appleBlack = Color(hex: "000000")
    
    // Ranking Colors
    public static let goldRank = Color(hex: "FFD700")
    public static let silverRank = Color(hex: "C0C0C0")
    public static let bronzeRank = Color(hex: "CD7F32")
    
    // Accent Solids (for non-gradient use)
    public static let accentTealSolid = Color(hex: "4FD6BE")
    public static let accentOrangeSolid = Color(hex: "FFB86C")
    public static func getGradient(colors: [Color]) -> LinearGradient {
        return LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Color Extensions

// Color(hex:) initializer is defined in Extensions/Color+Hex.swift
