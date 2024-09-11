import UIKit

/// Extension for add childViewController and switch between childs
extension UIViewController {
  
  /// Add viewController as child
  /// - Parameter containerView: ContainerView for child viewController
  /// - Parameter viewController: ViewController which will be add as child
  func addChild(to containerView: UIView, viewController: UIViewController) {
    addChild(viewController)
    containerView.addSubview(viewController.view)
    
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      viewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
      viewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor),
      viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
      viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
    
    viewController.didMove(toParent: self)
  }
  
  /// Remove child
  /// - Parameter viewController: ViewController to remove
  func removeChild(viewController: UIViewController) {
    viewController.willMove(toParent: nil)
    viewController.view.removeFromSuperview()
    viewController.removeFromParent()
  }
  
  /// Switch from one viewController to anoter
  /// - Parameter containerView: ContainerView for childViewController's view
  /// - Parameter current: Current childViewController
  /// - Parameter new: New childViewController
  func switchChild(in containerView: UIView, from current: UIViewController, to new: UIViewController) {
    current.willMove(toParent: nil)
    current.view.removeFromSuperview()
    current.removeFromParent()
    
    addChild(new)
    view.addSubview(new.view)
    new.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      new.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
      new.view.rightAnchor.constraint(equalTo: containerView.rightAnchor),
      new.view.topAnchor.constraint(equalTo: containerView.topAnchor),
      new.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
    new.didMove(toParent: self)
  }
  
  /// Gets reference to chilf view controller in children
  /// - Parameter childViewController: Type of view controller to reference
  func getReferenceToChild<Child: UIViewController>(viewController: Child.Type) -> Child? {
    return children.first { $0 is Child } as? Child
  }
}
