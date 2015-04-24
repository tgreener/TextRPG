//
//  DescriptiveStatisticTest.swift
//  TextRPG
//
//  Created by Todd Greener on 4/18/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import UIKit
import XCTest

class CharacterStatisticTest: XCTestCase {
    let stat = CharacterStatistic()
    
    override func setUp() {
        assert(stat.currentValue == 0, "Starting stat value invalid")
        assert(stat.currentProgression == 0, "Starting stat progression value invalid")
    }
    
    override func tearDown() {
        
    }
    
    func testGrowWithDefaultFunction() {
        stat.grow([0.5])
        assert(basicallyEquals(stat.currentProgression, 0.5), "Stat progression wrong after partial growth using default growth function. Expected : \( 0.5 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 0, "Stat value wrong after partial growth using default growth function. Expected : \( 0 ), Actual : \( stat.currentValue )")
        
        stat.grow([0.5])
        assert(basicallyEquals(stat.currentProgression, 0), "Stat progression wrong after single growth using default growth function. Expected : \( 0 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 1, "Stat value wrong after single growth using default growth function. Expected : \( 1 ), Actual : \( stat.currentValue )")
        
        stat.grow([1.2])
        assert(basicallyEquals(stat.currentProgression, 0.2), "Stat progression wrong after growth greater than single step. Expected : \( 0.2 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 2, "Stat value wrong after growth greater than single step. Expected : \( 2 ), Actual : \( stat.currentValue )")
        
        stat.grow([1.8])
        assert(basicallyEquals(stat.currentProgression, 0.0), "Stat progression wrong after multiple growth in single step. Expected : \(0.0), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 4, "Stat value wrong after multiple growth in single step. Expected : \(4), Actual : \( stat.currentValue )")
        
        stat.grow([6])
        assert(basicallyEquals(stat.currentProgression, 0.0), "Final stat progression wrong")
        assert(stat.currentValue == 10, "Final value wrong")
    }
    
    func testDecayWithDefaultFunction() {
        stat.grow([10])
        assert(basicallyEquals(stat.currentProgression, 0), "Stat progression start value wrong")
        assert(stat.currentValue == 10, "Starting stat value invalid")
        
        stat.decay([0.5])
        assert(basicallyEquals(stat.currentProgression, 0.5), "Stat progression wrong after partial decay using default growth function. Expected : \( 0.5 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 9, "Stat value wrong after partial decay using default decay function. Expected : \( 9 ), Actual : \( stat.currentValue )")
        
        stat.decay([0.2])
        assert(basicallyEquals(stat.currentProgression, 0.3), "Stat progression wrong after partial decay using default growth function. Expected : \( 0.3 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 9, "Stat value wrong after partial decay using default decay function. Expected : \( 9 ), Actual : \( stat.currentValue )")
        
        stat.decay([2.5])
        assert(basicallyEquals(stat.currentProgression, 0.8), "Stat progression wrong after multiple decay using default growth function. Expected : \( 0.8 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 6, "Stat value wrong after multiple decay using default decay function. Expected : \( 6 ), Actual : \( stat.currentValue )")
        
        stat.decay([0.8])
        assert(basicallyEquals(stat.currentProgression, 0.0), "Stat progression wrong after partial decay using default growth function. Expected : \( 0 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 6, "Stat value wrong after partial decay using default decay function. Expected : \( 6 ), Actual : \( stat.currentValue )")
        
        stat.decay([1.0])
        assert(basicallyEquals(stat.currentProgression, 0.0), "Stat progression wrong after single decay using default growth function. Expected : \( 0 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 5, "Stat value wrong after single decay using default decay function. Expected : \( 5 ), Actual : \( stat.currentValue )")
    }
    
    func testSetGrowFunction() {
        stat.setGrowthFunction { (startingValue, parameters) -> Float in
            if let params = parameters {
                if params.count == 2 {
                    return startingValue + (pow(params[0], 2) * 10) + params[1]
                }
            }
            
            return startingValue
        }
        
        stat.grow([0.2, 0])
        assert(basicallyEquals(stat.currentProgression, 0.4), "Stat progression wrong after partial growth using given growth function. Expected : \( 0.4 ), Actual : \( stat.currentProgression )")
        
        stat.grow([0.2, 0.1])
        assert(basicallyEquals(stat.currentProgression, 0.9), "Stat progression wrong after partial growth using given growth function. Expected : \( 0.4 ), Actual : \( stat.currentProgression )")
    }
    
    func testSetDecayFunction() {
        stat.setDecayFunction { (startingValue, parameters) -> Float in
            return startingValue - 0.1
        }
        
        stat.grow([10])
        stat.decay(nil)
        assert(basicallyEquals(stat.currentProgression, 0.9), "Stat progression wrong after partial decay using given growth function. Expected : \( 0.9 ), Actual : \( stat.currentProgression )")
        assert(stat.currentValue == 9, "Stat value wrong after partial decay using given decay function. Expected : \( 9 ), Actual : \( stat.currentValue )")
    }
    
    
}