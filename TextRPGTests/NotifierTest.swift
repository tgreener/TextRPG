//
//  ListenerTest.swift
//  TextRPG
//
//  Created by Todd Greener on 4/19/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import UIKit
import XCTest

class AListener {
    func receiveAnInt(anInt: Int) -> Void {
        assert(anInt == 10, "Wrong int received")
    }
}

class NotifierTest : XCTestCase {
    
    let notifier = Notifier<AListener>()
    let aListener = AListener()
    let anotherListener = AListener()
    
    override func setUp() {
        notifier.addListener(aListener)
        notifier.addListener(anotherListener)
    }
    
    func testNotification() {
        notifier.notify {(listener: AListener) -> Void in
            listener.receiveAnInt(10)
        }
    }
    
}
