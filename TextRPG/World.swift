//
//  World.swift
//  TextRPG
//
//  Created by Todd Greener on 5/28/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

class World : PortalListener, PickUpListener {
    let clock : WorldClock = GameWorldClock(at: TimeDefs.get(days: 1, hours: 8, minutes: 0))
    var rooms : [Room] = [Room]()
    
    init() {
        let player : Player = Player.instance
        
        let room0 : Room = WorldRoom()
        let room1 : Room = WorldRoom()
        let room2 : Room = WorldRoom()
        let room3 : Room = WorldRoom()
        
        rooms.append(room0)
        rooms.append(room1)
        rooms.append(room2)
        rooms.append(room3)
        
        let portalA : Entity = EntityFactory.createEntityWithPortal(to: room1)
        let portalB : Entity = EntityFactory.createEntityWithPortal(to: room0)
        let portalC : Entity = EntityFactory.createEntityWithPortal(to: room2)
        let portalD : Entity = EntityFactory.createEntityWithPortal(to: room3)
        let portalE : Entity = EntityFactory.createEntityWithPortal(to: room2)
        
        let aRock   : Entity = EntityFactory.createRock()
        let twigGenerator : Entity = EntityFactory.createTwigGenerator()
        
        room0.insert(aRock)
        room0.insert(portalA)
        room0.insert(portalC)
        room1.insert(portalB)
        room2.insert(portalB)
        room2.insert(portalD)
        room3.insert(portalE)
        room3.insert(twigGenerator)
        
        player.currentLocation = room0
        
        portalA.portal?.addListener(self)
        portalB.portal?.addListener(self)
        portalC.portal?.addListener(self)
        portalD.portal?.addListener(self)
        portalE.portal?.addListener(self)
        aRock.pickUp?.addListener(self)
        
        twigGenerator.generator?.addListener(room3)
        clock.addListener(twigGenerator.generator!)
    }
    
    func runSimulation(timeStep: WorldTime) {
        // Update all the things
        Commander.instance.runCommands()
        clock.progressClock(by: timeStep)
    }
    
    func entity(entity: Entity, used portal: Portal, to room: Room) {
        
    }
    
    func picked(up item: Entity, by entity: Entity, from container: EntityContainer) {
        
    }
}
