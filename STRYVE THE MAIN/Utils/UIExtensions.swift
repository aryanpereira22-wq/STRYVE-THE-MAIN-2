//
//  UIExtensions.swift
//  STRYVE THE MAIN
//
//  Created by Aryan Pereira on 08/10/2025.
//  Consolidated UI extensions and helpers to avoid duplicate declarations.
//

import SwiftUI

// MARK: - View Modifiers

extension View {
    /// Applies corner radius only to specified corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// Conditional view modifier
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Shape

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Color Extension

extension Color {
    /// Initialize Color from RGB values (0-255)
    init(r: Int, g: Int, b: Int, a: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0,
            opacity: a
        )
    }
}

// MARK: - View Helpers

/// Prevents keyboard from dismissing when interacting with other views
struct KeyboardDismissModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

extension View {
    /// Dismisses the keyboard when tapped outside text fields
    func dismissKeyboardOnTap() -> some View {
        self.modifier(KeyboardDismissModifier())
    }
}
