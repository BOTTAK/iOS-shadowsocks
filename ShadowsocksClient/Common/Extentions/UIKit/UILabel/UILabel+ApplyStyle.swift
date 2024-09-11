import UIKit

extension UILabel {
    
    func applyStyle(font: UIFont, textColor: UIColor, textAligment: NSTextAlignment = .left, text: String = "", numberOfLines: Int = 1) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAligment
        self.text = text
        self.numberOfLines = numberOfLines
    }
}
