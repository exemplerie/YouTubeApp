import Foundation

extension Date {
    func formattedWithDots() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM • d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
}
