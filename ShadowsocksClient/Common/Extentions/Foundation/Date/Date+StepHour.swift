import Foundation

/// Returns date after adding step to exists date based on direction
extension Date {
  
  // MARK: - Public Methods
  
  func stepHour(_ direction: StepDirection, count: Int = 1) -> Date {
    let calendar = Calendar.current
    let stepValue = direction == .forward ? count : -count
    
    return calendar.date(byAdding: .hour, value: stepValue, to: self) ?? self
  }
}
