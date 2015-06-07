//
//  Action.swift
//  TextRPG
//
//  Created by Todd Greener on 6/7/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol Action {
    var actionText : String { get }
    var duration : WorldTime { get }
    func enqueueCommand(from actor: Entity) -> Void
}