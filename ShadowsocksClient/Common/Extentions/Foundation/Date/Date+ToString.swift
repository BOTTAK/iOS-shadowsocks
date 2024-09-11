import Foundation

extension Date {
  
  // MARK: - Enums
  
  enum DateFormate: String {
    /// Date format like  "02 October 2019"
    case fullWithMonthName = "dd MMMM yyyy"
    
    /// Date format like  "02.10.2022"
    case fullWithDot = "dd.MM.yyyy"
    
    /// Date format like  "02.10"
    case dayMonthNumbers = "dd.MM"
    
    /// Date format like "02 October"
    case dayNumberMonthName = "dd MMMM"
    
    /// Date format like "02 October, 15:00"
    case dayNumberMonthNameAndTime = "dd MMMM, HH:mm"
    
    /// Hours and minutes like "15:00"
    case hoursAndMinutes = "HH:mm"
    
    /// Date format like "02 October 2022, 15:00"
    case ddMMMMyyyyHHmm = "dd MMMM yyyy, HH:mm"
    
    /// Date format like 2020-09-02T00:00:00
    case yyyyMMddT = "yyyy-MM-dd'T'00:00:00"
    
    /// Date format like "Sunday"
    case EEEE = "EEEE"
    
    /// Date format like "Sunday, 02 October 2019"
    case EEEEddMMMMyyyy = "EEEE, dd MMMM yyyy"
  }
  
  // MARK: - Public Methods
  
  /// Formate date to user frendly string
  ///
  /// - Parameter dateFormate: Date formate
  /// - Returns: Formatted date
  func toString(dateFormate: DateFormate) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormate.rawValue
    
    let formattedDate = dateFormatter.string(from: self)
    
    return formattedDate
  }
  
}
