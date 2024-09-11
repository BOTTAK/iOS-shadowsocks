import UIKit

extension UIViewController {
  
  var clearNavigationController: UINavigationController? {
    navigationItem.backBarButtonItem = UIBarButtonItem()
    return navigationController
  }
}
