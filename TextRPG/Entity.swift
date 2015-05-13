//
//  ObjecE.swift
//  TextRPG
//
//  Created by Todd Greener on 4/24/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

class Entity {
    let portal : Portal?
    
    var description : String {
        get {
            if let p = portal {
                return "a portal to \(p.targetRoom.name)"
            }
            else {
                return "a nondescript object."
            }
        }
    }
    
    init(portalComponent : Portal?) {
        portal = portalComponent
    }
}
