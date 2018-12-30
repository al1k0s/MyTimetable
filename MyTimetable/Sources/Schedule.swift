
import Foundation.NSDateFormatter

public struct Schedule: Codable {
    public var lessons: [Lesson]
    public var lessonTime: Set<LessonTime>
    public var periods: Set<Semester>

    public static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }
}

public struct Faculty: Codable {
    public var id: Int
    public var name, shortName: String?
    public var img: String?
    public var slug: String?
}

public struct Semester: Codable, Hashable, Identifieble {
    public enum Kind: Int, Codable {
        case firstSemester = 0
        case session = 3
        case secondSemester = 1
    }

    public var id: Int
    public var start, end: Date
    public var kind: Kind
}

public struct Lesson: Codable, Identifieble {
    public struct Room: Codable, Identifieble {
        public var id: Int
        public var num: String
        public var floor: Int
    }

    public struct Teacher: Codable, Identifieble {
        public var id: Int
        public var fullName, shortName: String?
        public var img: String
        public var degree: Int
        public var slug: String
    }

    public var id: Int
    public var nameFull, nameShort: String?
    public var housing: Faculty
    public var room: Room
    public var lessonTime: ForeignKey<LessonTime>
    public var format: Int
    public var subgroup: Int?
    public var teachers: [Teacher]
    public var dates: [Date]
    public var weeks: String
}
