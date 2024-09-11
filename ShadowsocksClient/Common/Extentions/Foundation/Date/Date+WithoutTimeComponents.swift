import Foundation

extension Date {
    
    func withoutTimeComponents() -> Date? {
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "UTC") {
            calendar.timeZone = timeZone
        }
        return calendar.date(withComponents: [.year, .month, .day], ofDate: self)
    }
    
    func noon() -> Date? {
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "UTC") {
            calendar.timeZone = timeZone
        }
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        dateComponents.hour = 12
        return calendar.date(from: dateComponents)
    }
}
