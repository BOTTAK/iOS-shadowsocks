import UIKit

extension UITableView {

  /// Registers a cell by nib with class for use in creating new table cells
  ///
  /// # Example
  /// ```
  /// @IBOutlet weak var tableView: UITableView!
  /// ...
  /// tableView.register(byNib: CustomTableViewCell.self)
  /// ```
  /// - Parameters:
  ///   - type: Type witch implementing UITableViewCell
  func register<T: UITableViewCell>(byNib type: T.Type) {
    let cellName = String(describing: T.self)
    let cellNib = UINib(nibName: cellName, bundle: nil)

    register(cellNib, forCellReuseIdentifier: cellName)
  }

  /// Registers a cell by class for use in creating new table cells
  ///
  /// # Example
  /// ```
  /// @IBOutlet weak var tableView: UITableView!
  /// ...
  /// tableView.register(byClass: CustomTableViewCell.self)
  /// ```
  /// - Parameters:
  ///   - type: Type witch implementing UITableViewCell
  func register<T: UITableViewCell>(byClass type: T.Type) {
    let cellName = String(describing: T.self)
    register(T.self, forCellReuseIdentifier: cellName)
  }
}
