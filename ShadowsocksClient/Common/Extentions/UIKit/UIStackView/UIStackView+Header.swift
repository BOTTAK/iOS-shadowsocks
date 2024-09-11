//import UIKit
//
///// Add header separation like in tableView
//extension UIStackView {
//
//  /// Add small separator in stackView
//  func addSmallHeader() {
//    let header = UIView.instantiate()
//    header.congfig(style: .small)
//    self.addArrangedSubview(header)
//  }
//
//  /// Add medium separator with title in stackView
//  ///
//  /// - Parameter title: title for header
//  func addHeaderWith(title: String) {
//    let header = UIView.instantiate()
//    header.congfig(style: .medium, title: title)
//    self.addArrangedSubview(header)
//  }
//
//  /// Add big header with title in stack view
//  /// - Parameter title: Header title
//  func addHeader(with style: SimpleHeaderView.SimpleHeaderViewStyle, title: String) {
//    let header = SimpleHeaderView.instantiate()
//
//    header.congfig(style: style, title: title, isUppercased: true)
//    addArrangedSubview(header)
//  }
//}
