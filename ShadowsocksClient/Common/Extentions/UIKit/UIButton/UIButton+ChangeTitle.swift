import UIKit

extension UIButton {
  
  /// Changing title with smooth animation
  ///
  /// - Parameters:
  ///   - title: new title
  ///   - color: title color
  func setTitleWithAnimation(title: String, color: UIColor = .black) {
    UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
      self.setTitleColor(color, for: .normal)
      self.setTitle(title, for: .normal)
    }, completion: nil)
  }
}
