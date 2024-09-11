import Foundation

extension Calendar {
    
    func date(withComponents components: Set<Component>, ofDate date: Date) -> Date? {
        let dateComponents = self.dateComponents(components, from: date)
        return self.date(from: dateComponents)
    }
}

extension Date {
    func ageInYearsAndMonths(from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date, to: self)
        
        guard let years = components.year, let months = components.month else {
            return ""
        }
        
        var ageString = ""
        
        if years == 0 {
            ageString = "\(months) \(monthsEnding(for: months))"
        } else {
            if Locale.current.languageCode == "ru" {
                if years > 0 {
                    ageString += "\(years) \(yearsEnding(for: years)) "
                }
                if months > 0 {
                    ageString += "\(months) \(monthsEnding(for: months))"
                }
            } else {
                if years > 0 {
                    ageString += "\(years) \(years > 1 ? "years" : "year") "
                }
                if months > 0 {
                    ageString += "\(months) \(months > 1 ? "months" : "month")"
                }
            }
        }
        
        return ageString
    }
    
    private func yearsEnding(for years: Int) -> String {
        switch years % 10 {
        case 1:
            return years % 100 == 11 ? "лет" : "год"
        case 2, 3, 4:
            return (years % 100 >= 12 && years % 100 <= 14) ? "лет" : "года"
        default:
            return "лет"
        }
    }
    
    private func monthsEnding(for months: Int) -> String {
        switch months % 10 {
        case 1:
            return months % 100 == 11 ? "месяцев" : "месяц"
        case 2, 3, 4:
            return (months % 100 >= 12 && months % 100 <= 14) ? "месяцев" : "месяца"
        default:
            return "месяцев"
        }
    }
}
