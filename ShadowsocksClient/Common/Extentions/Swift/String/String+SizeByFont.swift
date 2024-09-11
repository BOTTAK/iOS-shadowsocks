import Foundation
import UIKit

extension String {
    
    func size(with font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func countOfLines(inWidth width: CGFloat, font: UIFont) -> Int {
        let height = self.height(withConstrainedWidth: width, font: font)
        return self.countOfLines(inHeight: height, font: font)
    }
    
    func countOfLines(inHeight height: CGFloat, font: UIFont) -> Int {
        let countOfLines = Int(height / ceil(font.lineHeight))
        return countOfLines
    }
}
