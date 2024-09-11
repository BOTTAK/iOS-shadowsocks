import UIKit

extension UIFont {
    
    class func appFont(size: CGFloat, weight: Weight = .regular) -> UIFont {
        return self.satoshi(size: size, weight: weight) ?? .systemFont(ofSize: size, weight: weight)
    }
    
    class func satoshi(size: CGFloat, weight: Weight = .regular) -> UIFont? {
        var fontName: String
        switch weight {
        case .black:
            fontName = "Satoshi-Black"
        case .bold:
            fontName = "Satoshi-Bold"
        case .heavy:
            fontName = "Satoshi-Black"
        case .light:
            fontName = "Satoshi-Light"
        case .medium:
            fontName = "Satoshi-Medium"
        case .regular:
            fontName = "Satoshi-Regular"
        default:
            return nil
        }
        return UIFont(name: fontName, size: size)
    }
}
