import UIKit

extension UIView {
    func createLinearGradient(startColorHex: String, endColorHex: String) {
        // Create a CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds

        // Define the colors for the gradient
        let startColor = UIColor(hexString: startColorHex).cgColor
        let endColor = UIColor(hexString: endColorHex).cgColor
        gradientLayer.colors = [startColor, endColor]

        // Specify the direction of the gradient (horizontal in this case)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0) // Top
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)   // Bottom

        self.layer.addSublayer(gradientLayer)
    }
    
    func createHorizontalGradient(from startColor: String, to endColor: String) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hexString: startColor).cgColor,
            UIColor(hexString: endColor).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        return gradientLayer
    }
}
