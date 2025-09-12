//
//  FontTheme.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 07/08/2025.
//

import SwiftUI

struct FontTheme {
    // Display Fonts
    static let displayLarge = Font.system(size: 32, weight: .bold, design: .rounded)
    static let displayMedium = Font.system(size: 28, weight: .bold, design: .rounded)
    static let displaySmall = Font.system(size: 24, weight: .semibold, design: .rounded)
    
    // Headline Fonts
    static let headlineLarge = Font.system(size: 22, weight: .semibold, design: .default)
    static let headlineMedium = Font.system(size: 20, weight: .semibold, design: .default)
    static let headlineSmall = Font.system(size: 18, weight: .medium, design: .default)
    
    // Body Fonts
    static let bodyLarge = Font.system(size: 16, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 14, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 12, weight: .regular, design: .default)
    
    // Label Fonts
    static let labelLarge = Font.system(size: 14, weight: .medium, design: .default)
    static let labelMedium = Font.system(size: 12, weight: .medium, design: .default)
    static let labelSmall = Font.system(size: 10, weight: .medium, design: .default)
    
    // Special Fonts
    static let rankingNumber = Font.system(size: 36, weight: .black, design: .rounded)
    static let statsNumber = Font.system(size: 24, weight: .bold, design: .rounded)
    static let caption = Font.system(size: 11, weight: .regular, design: .default)
}
