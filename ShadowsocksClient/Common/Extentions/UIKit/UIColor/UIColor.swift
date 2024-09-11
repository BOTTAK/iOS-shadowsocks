import UIKit

extension UIColor {
  
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    let alpha, rColor, gColor, bColor: UInt32
    switch hex.count {
    case 3: // RGB (12-bit)
      (alpha, rColor, gColor, bColor) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (alpha, rColor, gColor, bColor) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (alpha, rColor, gColor, bColor) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (alpha, rColor, gColor, bColor) = (255, 0, 0, 0)
    }
    self.init(
      red: CGFloat(rColor) / 255,
      green: CGFloat(gColor) / 255,
      blue: CGFloat(bColor) / 255,
      alpha: CGFloat(alpha) / 255)
  }
}
