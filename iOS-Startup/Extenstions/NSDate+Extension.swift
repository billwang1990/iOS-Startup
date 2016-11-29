//
//  NSDate+Compare.swift
//  Pomodoro
//
//  Created by Yaqing Wang on 16/4/3.
//  Copyright © 2016年 billwang1990.github.io. All rights reserved.
//

import Foundation

public func < (first: Date, second: Date) -> Bool {
    return first.compare(second) == .orderedAscending
}

public func > (first: Date, second: Date) -> Bool {
    return first.compare(second) == .orderedDescending
}

public func <= (first: Date, second: Date) -> Bool {
    let cmp = first.compare(second)
    return cmp == .orderedAscending || cmp == .orderedSame
}

public func >= (first: Date, second: Date) -> Bool {
    let cmp = first.compare(second)
    return cmp == .orderedDescending || cmp == .orderedSame
}

public func == (first: Date, second: Date) -> Bool {
    return first.compare(second) == .orderedSame
}

extension Date {
    func isSameDay(_ anotherDay: Date) -> Bool {
        return self.yearMonthDayDescription() == anotherDay.yearMonthDayDescription()
    }
    
    func yearMonthDayDescription() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self)
    }
    
    func yearMonthDescription() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM"
        return format.string(from: self)
    }
    
    func monthDayDescription() -> String {
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        var str = format.string(from: self)
        if str.hasPrefix("0") {
            str = String(str.characters.dropFirst())
        }
        return str
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return (Calendar.current as NSCalendar).date(byAdding: components, to: startOfDay, options: NSCalendar.Options()) ?? self
    }
    
    var previousStartDay: Date {
        var components = DateComponents()
        components.day = -1
        return (Calendar.current as NSCalendar).date(byAdding: components, to: startOfDay, options: NSCalendar.Options()) ?? self
    }
    
    var previousEndDay: Date {
        var components = DateComponents()
        components.second = -1
        return (Calendar.current as NSCalendar).date(byAdding: components, to: startOfDay, options: NSCalendar.Options()) ?? self
    }
}
