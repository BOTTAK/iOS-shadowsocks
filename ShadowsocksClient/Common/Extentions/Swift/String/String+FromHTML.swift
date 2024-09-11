import UIKit

extension String {
  
  func fromHTML() -> NSAttributedString {
    let format = """
    <span style=\"font-family: '-apple-system', 'HelveticaNeue';
    font-size: \(UIFont.systemFont(ofSize: 16).pointSize)\">%@</span>
    """
  
    let modifiedFont = String(format: format, self)
    
    guard let data = modifiedFont.data(using: .unicode, allowLossyConversion: true) else { return NSAttributedString() }
    
    do {
      return try NSAttributedString(
      data: data,
      options: [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
      ],
      documentAttributes: nil)
    } catch {
      return NSAttributedString()
    }
  }
}
