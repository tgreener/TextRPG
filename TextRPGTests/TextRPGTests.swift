//
//  TextRPGTests.swift
//  TextRPGTests
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import UIKit
import XCTest

func basicallyEquals(a: Float, b: Float) -> Bool {
    return basicallyEquals(Double(a), Double(b))
}

func basicallyEquals(a: Double, b: Double) -> Bool {
    return abs(a - b) < 0.000001
}

