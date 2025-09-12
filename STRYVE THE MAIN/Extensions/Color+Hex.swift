// Color+Hex.swift
import SwiftUI

extension Color {
  /// Initialize with hex string like "#RRGGBB", "RRGGBB", "#RGB", or "AARRGGBB"
  init(hex: String) {
      var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
      hexSanitized = hexSanitized.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

      var int: UInt64 = 0
      Scanner(string: hexSanitized).scanHexInt64(&int)

      let r, g, b, a: UInt64
      switch hexSanitized.count {
      case 3: // RGB (12-bit)
          (r, g, b, a) = (((int >> 8) * 17), ((int >> 4 & 0xF) * 17), ((int & 0xF) * 17), 255)
      case 6: // RRGGBB (24-bit)
          (r, g, b, a) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF, 255)
      case 8: // AARRGGBB (32-bit)
          (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
      default:
          (r, g, b, a) = (0, 0, 0, 255)
      }

      self.init(.sRGB,
               red: Double(r) / 255.0,
               green: Double(g) / 255.0,
               blue: Double(b) / 255.0,
               opacity: Double(a) / 255.0)
  }
}
