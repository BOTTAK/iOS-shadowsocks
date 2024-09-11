import UIKit

extension UILabel {
    
    var countOfLines: Int {
        guard let text = self.text, let font = self.font else {
            return 1
        }
        return text.countOfLines(inWidth: self.frame.width, font: font)
    }
    
    var textWidthByConstrainedFrameHeight: CGFloat {
        guard let text = self.text, let font = self.font else {
            return 0
        }
        return text.width(withConstraintedHeight: self.frame.height, font: font)
    }
    
    var textWidthByConstrainedBoundsHeight: CGFloat {
        guard let text = self.text, let font = self.font else {
            return 0
        }
        return text.width(withConstraintedHeight: self.bounds.height, font: font)
    }
    
    var textHeightByConstrainedFrameWidth: CGFloat {
        guard let text = self.text, let font = self.font else {
            return 0
        }
        return text.height(withConstrainedWidth: self.frame.width, font: font)
    }
    
    var textHeightByConstrainedBoundsWidth: CGFloat {
        guard let text = self.text, let font = self.font else {
            return 0
        }
        return text.height(withConstrainedWidth: self.bounds.width, font: font)
    }
}
