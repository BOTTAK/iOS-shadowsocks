import Foundation

/// Returns start/end day of week
extension Date {
  
  // MARK: - Public Properties
  
  /// Returns start of current week date
  ///
  /// ```
  /// let currentDate = Date() // 07-01-2020
  /// let startOfWeek = currentDate.startOfWeek // 06-01-2020
  /// ```
  var startOfWeek: Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
    
    guard let resultDate = calendar.date(from: components) else {
      return self
    }
    
    return resultDate
  }
  
  /// Returns end of current week date
  ///
  /// ```
  /// let currentDate = Date() // 07-01-2020
  /// let endOfWeek = currentDate.endOfWeek // 12-01-2020
  /// ```
  var endOfWeek: Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
    
    guard
      let startOfWeekDate = calendar.date(from: components),
      let endOfWeekDate = calendar.date(byAdding: .day, value: 7, to: startOfWeekDate),
      let resultDate = calendar.date(byAdding: .second, value: -1, to: endOfWeekDate)
      else { return self }
    
    return resultDate
  }
}
