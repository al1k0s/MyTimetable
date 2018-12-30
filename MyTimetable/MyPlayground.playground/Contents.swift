import PlaygroundSupport
import MyTimetable
import iCalKit
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

let group = "IS-31"

var timetable: Schedule!

MyTimetable().downloadSchedule(groupName: group,
                               completion: { schedule in
                                timetable =
                                schedule
})


let events = timetable.lessonsEvents(subgroup: 1)


let event = events.first!

var calendar = Calendar(withComponents: nil)

let timeZone = Foundation.Calendar.current.timeZone
//calendar.add(component: timeZone)

timeZone.toCal()

for event in timetable.lessonsEvents(subgroup: 1) {
    calendar.append(component: event)
}

calendar.toCal()

let icalData = calendar.toCal()

let desktopDir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0]

let icalLocation = desktopDir.appendingPathComponent("перший семестр.ics")

func saveCalendar() {
    try! calendar.toCal().data(using: .utf8)?.write(to: icalLocation)
}

let timezone = TimeZone.current

timezone.abbreviation()

timezone.daylightSavingTimeOffset()

timezone.isDaylightSavingTime()

saveCalendar()

calendar.add(component: timetable.firstSemesterEvent)

calendar.add(component: timetable.sessionEvent)

saveCalendar()


