import Foundation

extension String {
  
  var toNilIfEmpty: String? {
    return isEmpty ? nil : self
  }
}
