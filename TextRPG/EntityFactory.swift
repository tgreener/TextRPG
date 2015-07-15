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
        let portal : Portal = GamePortal(to: room, duration: 1.0)
        return EntityBuilder().with(portal).build()
    }
    
    static func createRock() -> Entity {
        let rockPickUp : PickUp = PickUpItem(name: "rock", description: "a really nice rock", duration: 1.0)
        return EntityBuilder().with(rockPickUp).build()
    }
    
    static func createTwig() -> Entity {
        let twigPickUp : PickUp = PickUpItem(name: "twig", description: "a short twig", duration: 1.0)
        return EntityBuilder().with(twigPickUp).build()
    }
    
    static func createTwigGenerator() -> Entity {
        let generationTimeRange : TimeRange = TimeRange(min: 5, max: 10)
        let twigGenerator : Generator = GeneratorComponent(timeRange: generationTimeRange, generationFunction: {
            return EntityFactory.createTwig()
        })
        return EntityBuilder().with(twigGenerator).build()
    }
}

class EntityBuilder {
    var portal   : Portal? = nil
    var pickUp   : PickUp? = nil
    var inventory: Inventory? = nil
    var location : Location? = nil
    var generator: Generator? = nil
    
    func with(portal : Portal) -> EntityBuilder {
        self.portal = portal
        return self
    }
    
    func with(pickUp: PickUp) -> EntityBuilder {
        self.pickUp = pickUp
        return self
    }
    
    func with(inventory: Inventory) -> EntityBuilder {
        self.inventory = inventory
        return self
    }
    
    func with(location: Location) -> EntityBuilder {
        self.location = location
        return self
    }
    
    func with(generator: Generator) -> EntityBuilder {
        self.generator = generator
        return self
    }
    
    func build() -> Entity {
        return Entity(
            portalComponent: self.portal,
            pickUpComponent: self.pickUp,
            inventoryComponent: self.inventory,
            locationComponent: self.location,
            generatorComponent: self.generator
        )
    }
}
