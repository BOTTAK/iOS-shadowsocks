import UIKit

extension UIViewController {
    static func identifier() -> String {
        return String(describing: self)
    }
}
