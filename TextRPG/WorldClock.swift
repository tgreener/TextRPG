//
//  File.swift
//  TextRPG
//
//  Created by Todd Greener on 4/18/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

typealias WorldTime = Double

protocol WorldClock {
    var currentTime : WorldTime { get }
    var currentDay  : WorldTime { get }
    var currentHour : WorldTime { get }
    var currentMinute : WorldTime { get }
    
    func progressClock(by time: WorldTime) -> Void
    func addListener(listener: WorldClockListener) -> Void
    func toString() -> String
}

protocol WorldClockListener : class {
    func worldClockDidProgress(by delta: WorldTime, currentTime : WorldTime) -> Void
}

struct TimeDefs {
    static let secondsInMinute : WorldTime = 60
    static let secondsInHour   : WorldTime = secondsInMinute * 60
    static let secondsInDay    : WorldTime = secondsInHour * 24
    
    static func get(minutes m: UInt) -> WorldTime {
        return TimeDefs.secondsInMinute * WorldTime(m)
    }
    
    static func get(hours h: UInt) -> WorldTime {
        return TimeDefs.secondsInHour * WorldTime(h)
    }
    
    static func get(days d: UInt) -> WorldTime {
        return TimeDefs.secondsInDay * WorldTime(d)
    }
    
    static func get(days d: UInt, hours: UInt, minutes: UInt) -> WorldTime {
        return get(minutes: minutes) + get(hours: hours) + get(days: d)
    }
    
    static func get(hours h: UInt, minutes: UInt) -> WorldTime {
        return get(hours: h) + get(minutes: minutes)
    }
    
    static func get(days d: UInt, minutes: UInt) -> WorldTime {
        return get(days: d) + get(minutes: minutes)
    }
}

class GameWorldClock : WorldClock {
    
    let notifier : Notifier<WorldClockListener> = Notifier<WorldClockListener>()
    var currentTime : WorldTime = 0
    
    var currentDay : WorldTime {
        get {
            return floor(currentTime / TimeDefs.secondsInDay)
        }
    }
    
    var currentHour : WorldTime {
        get {
            let timeToday : WorldTime = currentTime - (currentDay * TimeDefs.secondsInDay)
            
            return floor(timeToday / TimeDefs.secondsInHour)
        }
    }
    
    var currentMinute : WorldTime {
        get {
            let timeInCurrentHour : WorldTime = currentTime - ((currentHour * TimeDefs.secondsInHour) + (currentDay * TimeDefs.secondsInDay))
            
            return floor(timeInCurrentHour / TimeDefs.secondsInMinute)
        }
    }
    
    init() {
        
    }
    
    init(at time: WorldTime) {
        currentTime = time
    }
    
    func progressClock(by time: WorldTime) -> Void {
        currentTime += time
        notifier.notify { (listener: WorldClockListener) in
            listener.worldClockDidProgress(by: time, currentTime: self.currentTime)
        }
    }
    
    func addListener(listener: WorldClockListener) -> Void {
        notifier.addListener(listener)
    }
    
    func toString() -> String {
        return String(format: "Day %.0f, %.0f:%.0f", arguments: [currentDay, currentHour, currentMinute]) // TODO: Implement world clock to string
    }
}
