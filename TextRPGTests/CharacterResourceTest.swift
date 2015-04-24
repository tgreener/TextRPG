//
//  CharacterResourceTest.swift
//  TextRPG
//
//  Created by Todd Greener on 4/18/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import UIKit
import XCTest

class CharacterResourceTest : XCTestCase {
    
    let res = BaseCharacterResource(startingValue: 50)
    
    func testIncrease() {
        res.increase(10)
        assert(res.currentValue == 60, "")
        
        res.increase(40)
        assert(res.currentValue == 100, "")
        
        res.increase(1)
        assert(res.currentValue == res.MAX_VALUE, "")
    }
    
    func testDecrease() {
        res.decrease(10)
        assert(res.currentValue == 40, "")
        
        res.decrease(40)
        assert(res.currentValue == 0, "")
        
        res.decrease(1)
        assert(res.currentValue == 0, "")
    }
    
}
