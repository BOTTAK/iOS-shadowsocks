import Foundation

extension Date {
  
  var endOfDay: Date {
    var components = DateComponents()
    
    components.day = 1
    components.second = -1
    
    guard let currentDate = Calendar.current.date(byAdding: components, to: startOfDay) else {
      return Date()
    }
    
    return currentDate
  }
  
}
