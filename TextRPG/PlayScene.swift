//
//  PlayScene.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class PlayScene: BaseScene, PortalListener {
    
    var display : TextDisplay! = nil
    
    override func createSceneContents() {
        super.createSceneContents()
        initGame()
        
        display = TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) * 1.5))
        display.size = CGSizeMake(self.frame.width, self.frame.height / 2)
        addChild(display)
        
        displayCurrentPlayerLocation()
    }
    
    func displayCurrentPlayerLocation() {
        display.text = "You are currently in \(Player.instance.currentLocation.description)"
    }
    
    func initGame() {
        var player : PlayerCharacter = Player.instance
        
        var room0 : Room = WorldRoom()
        var room1 : Room = WorldRoom()
        let portalA : Entity = EntityFactory.createEntityWithPortal(to: room1)
        let portalB : Entity = EntityFactory.createEntityWithPortal(to: room0)
        
        room0.entities.append(portalA)
        room1.entities.append(portalB)
        
        player.currentLocation = room0
    }
    
    func playerUsed(#portal: Portal, to room: Room) {
        var player = Player.instance
        player.currentLocation = room
        displayCurrentPlayerLocation()
    }
    
}
