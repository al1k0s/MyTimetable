
import Foundation

public struct LessonTime: Codable, Hashable, Identifieble {
    public var id: Int
    public var start, end: String
    public var num: Int
    public var hasBreak: Bool
    public var halfEnd, halfStart: String

    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    func timeComponents(_ string: String, _ calendar: Foundation.Calendar = .current) -> DateComponents {
        let date = type(of: self).formatter.date(from: string)!
        let timeComponent = calendar.dateComponents([.hour, .minute],
                                                    from: date)
        return timeComponent
    }

    public func lessonStartDate(date: Date, _ calendar: Foundation.Calendar = .current) -> Date {
        let timeComponent = timeComponents(start, calendar)
        return calendar.date(byAdding: timeComponent, to: date)!
    }

    public func lessonEndDate(date: Date, _ calendar: Foundation.Calendar = .current) -> Date {
        let timeComponent = timeComponents(end, calendar)
        return calendar.date(byAdding: timeComponent, to: date)!
    }

    public func lessonHalfEndDate(date: Date, _ calendar: Foundation.Calendar = .current) -> Date {
        let timeComponent = timeComponents(halfEnd, calendar)
        return calendar.date(byAdding: timeComponent, to: date)!
    }

    public func lessonHalfStartDate(date: Date, _ calendar: Foundation.Calendar = .current) -> Date {
        let timeComponent = timeComponents(halfStart, calendar)
        return calendar.date(byAdding: timeComponent, to: date)!
    }
}
