import UIKit

extension UICollectionView {
  
  /// Returns a reusable collection view cell object by class with index path
  ///
  /// # Example
  /// ```
  /// @IBOutlet weak var collectionView: UICollectionView!
  /// ...
  /// let indexPath = IndexPath(row: 0, section: 0)
  /// let cell = collectionView.dequeueReusableCell(byClass: CustomCollectionViewCell.self, for: indexPath)
  /// ```
  /// - Parameters:
  ///   - type: Type witch implementing UICollectionViewCell
  ///   - indexPath: The index path specifying the location of the cell
  func dequeueReusableCell<T: UICollectionViewCell>(byClass type: T.Type, for indexPath: IndexPath) -> T {
    let cellName = String(describing: T.self)
    let reusableCell = dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath)
    
    guard let cell = reusableCell as? T else {
      fatalError("Unexpected collection view cell \(cellName)")
    }
    
    return cell
  }
}
