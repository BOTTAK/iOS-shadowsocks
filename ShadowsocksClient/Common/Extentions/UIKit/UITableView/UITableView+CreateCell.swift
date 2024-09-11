import UIKit

extension UITableView {
  
  /// Returns a reusable table view cell object by class
  ///
  /// # Example
  /// ```
  /// @IBOutlet weak var tableView: UITableView!
  /// ...
  /// let cell = tableView.dequeueReusableCell(byClass: CustomTableViewCell.self)
  /// ```
  /// - Parameters:
  ///   - type: Type witch implementing UITableViewCell
  func dequeueReusableCell<T: UITableViewCell>(byClass type: T.Type) -> T {
    let cellName = String(describing: T.self)
    let reusableCell = dequeueReusableCell(withIdentifier: cellName)
    
    guard let cell = reusableCell as? T else {
      fatalError("Unexpected table view cell \(cellName)")
    }
    
    return cell
  }
  
  /// Returns a reusable table view cell object by class with index path
  ///
  /// # Example
  /// ```
  /// @IBOutlet weak var tableView: UITableView!
  /// ...
  /// let indexPath = IndexPath(row: 0, section: 0)
  /// let cell = tableView.dequeueReusableCell(byClass: CustomTableViewCell.self, for: indexPath)
  /// ```
  /// - Parameters:
  ///   - type: Type witch implementing UITableViewCell
  ///   - indexPath: The index path specifying the location of the cell
  func dequeueReusableCell<T: UITableViewCell>(byClass type: T.Type, for indexPath: IndexPath) -> T {
    let cellName = String(describing: T.self)
    let reusableCell = dequeueReusableCell(withIdentifier: cellName, for: indexPath)
    
    guard let cell = reusableCell as? T else {
      fatalError("Unexpected table view cell \(cellName)")
    }
    
    return cell
  }
}
