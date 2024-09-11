import UIKit

/// Select and deselect all rows in TableView
extension UITableView {
  
  func selectAllRows() {
    for section in 0..<numberOfSections {
      for row in 0..<numberOfRows(inSection: section) {
        selectRow(
          at: .init(row: row, section: section),
          animated: true,
          scrollPosition: .none
        )
      }
    }
  }
  
  func deSelectAllRows() {
    for section in 0..<numberOfSections {
      for row in 0..<numberOfRows(inSection: section) {
        deselectRow(
          at: .init(row: row, section: section),
          animated: true
        )
      }
    }
  }
}
