//
//  ObjecE.swift
//  TextRPG
//
//  Created by Todd Greener on 4/24/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol EntityContainer : class {
    var entities : [Entity] { get set }
}

class Entity {
    let portal : Portal?
    let pickUp : PickUp?
    
    var description : String {
        get {
            if let p = portal {
                return "a portal to \(p.targetRoom.name)"
            }
            else if let pu = pickUp {
                return "\(pu.description)"
            }
            else {
                return "a nondescript object."
            }
        }
    }
    
    init(portalComponent : Portal?, pickUpComponent : PickUp?) {
        portal = portalComponent
        pickUp = pickUpComponent
        
        pickUp?.entity = self
    }
}
