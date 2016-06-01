//
//  File.swift
//  TextRPG
//
//  Created by Todd Greener on 4/23/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import UIKit
import XCTest

class WorldClockTest: XCTestCase {
    
    let clock : WorldClock = GameWorldClock(at: TimeDefs.get(days: 10, hours: 5, minutes: 40))
    
    override func setUp() {
    }
    
    func testGetCurrenDay() -> Void {
        assert(basicallyEquals(clock.currentDay, b: 10), "Wrong day value")
    }
    
    func testGetCurrentHour() -> Void {
        assert(basicallyEquals(clock.currentHour, b: 5), "Wrong hour value")
    }
    
    func testGetCurrentMinute() -> Void {
        assert(basicallyEquals(clock.currentMinute, b: 40), "Wrong minute value")
    }
    
    func testToString() -> Void {
        assert(clock.toString() == "Day 10, 5:40:00", "Wrong string from toString(): \(clock.toString())")
    }
    
    func testProgressClock() -> Void {
        clock.progressClock(by: TimeDefs.get(minutes: 20))
        assert(basicallyEquals(clock.currentMinute, b: 0), "Wrong Minutes: \(clock.currentMinute)")
        assert(basicallyEquals(clock.currentHour, b: 6), "Wrong Hour: \(clock.currentHour)")
        assert(basicallyEquals(clock.currentDay, b: 10), "Wrong Day: \(clock.currentDay)")
        
        clock.progressClock(by: TimeDefs.get(hours: 18))
        assert(basicallyEquals(clock.currentMinute, b: 0), "Wrong Minutes: \(clock.currentMinute)")
        assert(basicallyEquals(clock.currentHour, b: 0), "Wrong Hour: \(clock.currentHour)")
        assert(basicallyEquals(clock.currentDay, b: 11), "Wrong Day: \(clock.currentDay)")

        clock.progressClock(by: TimeDefs.get(hours: 5, minutes: 40))
        assert(basicallyEquals(clock.currentMinute, b: 40), "Wrong Minutes: \(clock.currentMinute)")
        assert(basicallyEquals(clock.currentHour, b: 5), "Wrong Hour: \(clock.currentHour)")
        assert(basicallyEquals(clock.currentDay, b: 11), "Wrong Day: \(clock.currentDay)")
    }
}
