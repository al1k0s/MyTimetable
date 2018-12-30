//
//  Schedule+iCal.swift
//  MyTimetable
//
//  Created by Alik Vovkotrub on 12/30/18.
//  Copyright © 2018 Alik Vovkotrub. All rights reserved.
//

import iCalKit
import struct Foundation.Calendar

extension Schedule {
    public var firstSemesterEvent: Event {
        let semester = periods.first {
            $0.kind == .firstSemester
            }!

        var event = Event()

        event.endDate = semester.end
        event.startDate = semester.start
        event.summary = "Перший семестр"

        return event
    }

    public var sessionEvent: Event {
        let session = periods.first {
            $0.kind == .session
            }!

        var event = Event()

        event.endDate = session.end
        event.startDate = session.start
        event.summary = "Сесія"

        return event
    }

    public func lessonsEvents(subgroup: Int,
                       calendar: Foundation.Calendar = .current) -> Set<Event> {
        var lessonsEvents = Set<Event>()

        for lesson in lessons where [subgroup, nil].contains(lesson.subgroup) {
            for date in lesson.dates {
                var event = Event()

                let lessonTime = lesson.lessonTime.get(from: self.lessonTime)!

                event.endDate = lessonTime.lessonEndDate(date: date)
                event.startDate = lessonTime.lessonStartDate(date: date)
                event.summary = lesson.nameFull
                event.location = lesson.room.num

                lessonsEvents.insert(event)
            }
        }

        return lessonsEvents
    }
}
