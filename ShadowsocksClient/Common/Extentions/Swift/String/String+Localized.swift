import Foundation

extension String {
  
  /// Make string as localized key
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
