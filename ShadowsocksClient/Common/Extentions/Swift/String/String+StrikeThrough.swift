import Foundation

extension String {
  
  /// Apply strike font on text
  func strikeThrough() -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    
    attributeString.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: 1,
      range: NSRange(location: 0, length: attributeString.length)
    )

    return attributeString
  }
}
