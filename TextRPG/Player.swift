//
//  Player.swift
//  TextRPG
//
//  Created by Todd Greener on 5/4/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol PlayerCharacter {
    var currentLocation : Room! { get set }
    var inventory : Inventory? { get }
}

class Player : Entity, PlayerCharacter {
    var currentLocation : Room! {
        get {
            return self.location?.currentLocation
        }
        set {
            if let location = self.location {
                (location as! LocationComponent).currentLocation = newValue
            }
        }
    }
    
    static let instance : Player = Player(
        portalComponent: nil,
        pickUpComponent: nil,
        inventoryComponent: InventoryComponent(),
        locationComponent: LocationComponent(),
        generatorComponent: nil
    )
}
