import UIKit

/// Change style navigation bar to transparent with gradient of default
extension UINavigationController {
  
  // MARK: - Public Methods
  
  func makeNavigationBarTransparent() {
    let backgroundImage = navigationBarGradientBackground()
    
    navigationBar.tintColor = .white
    navigationBar.backgroundColor = .clear
    navigationBar.setBackgroundImage(backgroundImage, for: .default)
    navigationBar.shadowImage = UIImage()
    
    if #available(iOS 13.0, *) {
      navigationBar.standardAppearance.configureWithTransparentBackground()
      navigationBar.standardAppearance.backgroundImage = backgroundImage
      navigationBar.standardAppearance.backgroundColor = .clear
    }
  }
  
  func makeNavigationBarDefault() {
    navigationBar.tintColor = .blue
    navigationBar.backgroundColor = nil
    navigationBar.setBackgroundImage(nil, for: .default)
    navigationBar.shadowImage = nil
    
    if #available(iOS 13.0, *) {
      navigationBar.standardAppearance.configureWithDefaultBackground()
    }
  }
  
  // MARK: - Private Methods
  
  private func navigationBarGradientBackground() -> UIImage {
    let gradientLayer = CAGradientLayer()
    var bounds = navigationBar.bounds
    
    bounds.size.height += UIApplication.shared.statusBarFrame.size.height
    gradientLayer.frame = bounds
    gradientLayer.colors = [
      UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3).cgColor,
      UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    
    return getImage(from: gradientLayer) ?? UIImage()
  }
  
  private func getImage(from gradientLayer: CAGradientLayer) -> UIImage? {
    var gradientImage: UIImage?
    
    UIGraphicsBeginImageContext(gradientLayer.frame.size)
    
    if let context = UIGraphicsGetCurrentContext() {
      gradientLayer.render(in: context)
      gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(
        withCapInsets: UIEdgeInsets.zero,
        resizingMode: .stretch)
    }
    
    UIGraphicsEndImageContext()
    
    return gradientImage
  }
}
