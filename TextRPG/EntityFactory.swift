//
//  EntityFactory.swift
//  TextRPG
//
//  Created by Todd Greener on 5/7/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

class EntityFactory {
    static func createEntityWithPortal(to room: Room) -> Entity {
        let portal : Portal = GamePortal(to: room)
        return Entity(portalComponent: portal, pickUpComponent: nil)
    }
    
    static func createRock() -> Entity {
        let rockPickUp : PickUp = PickUpItem(name: "rock", description: "a really nice rock")
        return Entity(portalComponent: nil, pickUpComponent: rockPickUp)
    }
}
