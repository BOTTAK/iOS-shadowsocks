import UIKit

extension UISlider {
    func setCustomThumbAppearance(color: UIColor = UIColor(hexString: "#006AFF"),
                                  borderColor: UIColor = .white,
                                  borderWidth: CGFloat = 4.0,
                                  size: CGSize = CGSize(width: 22, height: 22)) {
        let thumbImage = createThumbImage(color: color, borderColor: borderColor, borderWidth: borderWidth, size: size)
        self.setThumbImage(thumbImage, for: .normal)
    }
    
    private func createThumbImage(color: UIColor, borderColor: UIColor, borderWidth: CGFloat, size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let path = UIBezierPath(ovalIn: rect)
        color.setFill()
        path.fill()
        
        borderColor.setStroke()
        path.lineWidth = borderWidth
        path.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
