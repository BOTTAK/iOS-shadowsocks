import UIKit

extension UINavigationController {

  /// Gets reference to view controller in navigation stack
  /// - Parameter viewController: Type of view controller to reference
    func getReference<ViewController: UIViewController>(to viewController: ViewController.Type) -> ViewController? {
        return viewControllers.first { $0 is ViewController } as? ViewController
    }
}
