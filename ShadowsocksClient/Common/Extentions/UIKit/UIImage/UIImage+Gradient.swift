import UIKit

extension UIImage {
    func applyGradient(colors: [UIColor], locations: [NSNumber], alphaValues: [CGFloat]) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext(),
              let cgImage = cgImage else {
            return nil
        }

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        // Draw the image
        draw(in: rect)

        // Create gradient mask
        let gradient = CAGradientLayer()
        gradient.frame = rect
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        gradient.opacity = 1.0

        // Apply alpha values to gradient stops
        for (index, alpha) in alphaValues.enumerated() {
            if let color = gradient.colors?[index] {
                gradient.colors?[index] = (color as AnyObject).copy(alpha)
            }
        }

        // Render gradient into context
        gradient.render(in: context)

        // Create masked image
        guard let maskedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }

        UIGraphicsEndImageContext()

        return maskedImage
    }
}
