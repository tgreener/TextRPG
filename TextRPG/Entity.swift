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
    func insert(entity: Entity) -> Void
}

class Entity {
    let portal : Portal?
    let pickUp : PickUp?
    let inventory : Inventory?
    var actions : [Action] = [Action]()
    
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
    
    init(portalComponent : Portal?, pickUpComponent : PickUp?, inventoryComponent : Inventory?) {
        portal = portalComponent
        pickUp = pickUpComponent
        inventory = inventoryComponent
        
        pickUp?.entity = self
        if let a = portal { actions.append(a) }
        if let a = pickUp { actions.append(a) }
    }
}
