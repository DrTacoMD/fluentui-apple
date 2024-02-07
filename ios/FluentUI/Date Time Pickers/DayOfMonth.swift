//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation
#if SWIFT_MODULE
import FluentUI_Core_iOS
#endif

// MARK: DayOfMonth

public struct DayOfMonth {
    public let weekOfMonth: WeekOfMonth
    public let dayOfWeek: DayOfWeek

    public init(weekOfMonth: WeekOfMonth? = nil, dayOfWeek: DayOfWeek? = nil) {
        self.weekOfMonth = weekOfMonth ?? .first
        self.dayOfWeek = dayOfWeek ?? DayOfWeek.allCases.first!
    }
}

// MARK: - WeekOfMonth

@objc(MSFWeekOfMonth)
public enum WeekOfMonth: Int, CaseIterable {
    case first = 1, second, third, fourth, last

    public init?(weekdayOrdinal: Int) {
        self.init(rawValue: weekdayOrdinal)
    }

    public var label: String {
        switch self {
        case .first:
            return FluentUIFramework.localized("Accessibility.DateTime.Week.First")
        case .second:
            return FluentUIFramework.localized("Accessibility.DateTime.Week.Second")
        case .third:
            return FluentUIFramework.localized("Accessibility.DateTime.Week.Third")
        case .fourth:
            return FluentUIFramework.localized("Accessibility.DateTime.Week.Fourth")
        case .last:
            return FluentUIFramework.localized("Accessibility.DateTime.Week.Last")
        }
    }

    public var weekdayOrdinal: Int { return rawValue }
}

// MARK: - DayOfWeek

@objc(MSFDayOfWeek)
public enum DayOfWeek: Int {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday

    static var allCases: [DayOfWeek] {
        var daysOfWeek: [DayOfWeek] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        for _ in 0..<Calendar.current.firstWeekday - 1 {
            daysOfWeek.append(daysOfWeek.removeFirst())
        }
        return daysOfWeek
    }

    private static let weekdaySymbols: [String] = Calendar.sharedCalendarWithTimeZone(nil).weekdaySymbols

    public var label: String {
        return DayOfWeek.weekdaySymbols[rawValue]
    }

    var weekday: Int { return rawValue + 1 }
}
