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
        var player : PlayerCharacter = Player.instance
        
        var room0 : Room = WorldRoom()
        var room1 : Room = WorldRoom()
        var room2 : Room = WorldRoom()
        
        rooms.append(room0)
        rooms.append(room1)
        rooms.append(room2)
        
        let portalA : Entity = EntityFactory.createEntityWithPortal(to: room1)
        let portalB : Entity = EntityFactory.createEntityWithPortal(to: room0)
        let portalC : Entity = EntityFactory.createEntityWithPortal(to: room2)
        
        let aRock : Entity = EntityFactory.createRock()
        
        room0.insert(aRock)
        room0.insert(portalA)
        room0.insert(portalC)
        room1.insert(portalB)
        room2.insert(portalB)
        
        player.currentLocation = room0
        
        portalA.portal?.addListener(self)
        portalB.portal?.addListener(self)
        portalC.portal?.addListener(self)
        aRock.pickUp?.addListener(self)
    }
    
    func runSimulation(timeStep: WorldTime) {
        // Update all the things
        Commander.instance.runCommands()
        clock.progressClock(by: timeStep)
    }
    
    func entity(entity: Entity, used portal: Portal, to room: Room) {
        var player = Player.instance
        player.currentLocation = room
    }
    
    func picked(up item: Entity, by entity: Entity, from container: EntityContainer) {
        
    }
}
