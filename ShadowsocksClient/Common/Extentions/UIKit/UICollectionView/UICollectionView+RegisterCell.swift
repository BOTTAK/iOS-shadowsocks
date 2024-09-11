import UIKit

extension UICollectionView {
  
  /// Registers a cell by class for use in creating new collection cells
  ///
  /// # Example
  /// ```
  /// @IBOutlet weak var collectionView: UICollectionView!
  /// ...
  /// collectionView.register(byClass: CustomCollectionViewCell.self)
  /// ```
  /// - Parameters:
  ///   - type: Type witch implementing UICollectionViewCell
  func register<T: UICollectionViewCell>(byClass type: T.Type) {
    let cellName = String(describing: T.self)
    register(T.self, forCellWithReuseIdentifier: cellName)
  }
  
  /// Registers a cell by nib with class for use in creating new collection cells
  ///
  /// # Example
  /// ```
  /// @IBOutlet weak var collectionView: UICollectionView!
  /// ...
  /// collectionView.register(byClass: CustomCollectionViewCell.self)
  /// ```
  /// - Parameters:
  ///   - type: Type witch implementing UICollectionViewCell
  func register<T: UICollectionViewCell>(byNib type: T.Type) {
    let cellName = String(describing: T.self)
    let cellNib = UINib(nibName: cellName, bundle: nil)

    register(cellNib, forCellWithReuseIdentifier: cellName)
  }
}
