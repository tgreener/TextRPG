//
//  Inventory.swift
//  TextRPG
//
//  Created by Todd Greener on 5/13/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol Inventory : EntityContainer {
    
}

class InventoryComponent : Inventory {
    var entities : [Entity] = [Entity]()
    
    func insert(entity: Entity) -> Void {
        entities.append(entity)
        if let pickUp : PickUp = entity.pickUp {
            (pickUp as! PickUpItem).container = self
        }
    }
    
    func onGenerated(entity entity: Entity) {
        insert(entity)
    }
}
