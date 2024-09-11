import Foundation
import UIKit



extension Formatter {
    static let yyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM-dd"
        return formatter
    }()
}

extension String {
    var yyyMMddToDate: Date? {
        Formatter.yyyMMdd.date(from: self)
    }
}
