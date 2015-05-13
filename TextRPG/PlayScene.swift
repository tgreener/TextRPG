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
    var actionBox : TextDisplay! = nil
    var actionDisplays: [TextDisplay] = [TextDisplay]()
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        print("touched")
//    }
    
    override func createSceneContents() {
        super.createSceneContents()
        initGame()
        self.backgroundColor = StyleGuide.defaultBackgroundColor()
        
        let displaySize = CGSizeMake(self.frame.width - StyleGuide.elementMargin() * 2, (self.frame.height / 2) - StyleGuide.elementMargin() * 2)
        display = TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - StyleGuide.elementMargin()), size: displaySize)
        addChild(display)
        
        let actionBoxSize = CGSizeMake(self.frame.width - StyleGuide.elementMargin() * 2, (self.frame.height / 3) - StyleGuide.elementMargin() * 2)
        actionBox = TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(display.frame) - StyleGuide.elementMargin()), size: actionBoxSize)
        addChild(actionBox)
        
        refreshDisplay()
    }
    
    func refreshDisplay() {
        clearActionDisplays()
        display.text = "You are currently in \(Player.instance.currentLocation.description)"
        
        var currentRoom : Room = Player.instance.currentLocation
        for entity in currentRoom.entities {
            if let p = entity.portal {
                let portalDisplay = createPortalAction(p)
                portalDisplay.touchHandler = {
                    p.traverse()
                }
                actionDisplays.append(portalDisplay)
            }
        }
        
        for var i : Int = 0; i < actionDisplays.count; i++ {
            let yPos : CGFloat = ((StyleGuide.elementMargin() + actionDisplays[i].size.height) * -CGFloat(i)) - StyleGuide.elementMargin()
            actionDisplays[i].position = CGPoint(x: 0, y: yPos)
            actionBox.addChild(actionDisplays[i])
        }
    }
    
    func clearActionDisplays() {
        for actionDisplay in actionDisplays {
            actionDisplay.removeFromParent()
        }
    }
    
    func createPortalAction(portal: Portal) -> TextDisplay {
        let portalDisplaySize = CGSizeMake(actionBox.size.width - StyleGuide.elementMargin() * 2, StyleGuide.actionButtonTextSize())
        let portalDisplay : TextDisplay = TextDisplay(at: CGPoint.zeroPoint, size:portalDisplaySize) // TODO: Need to make TextDisplay font resizable for titles and action buttons
        
        portalDisplay.text = "Take portal to \(portal.targetRoom.name)"
        
        return portalDisplay
    }
    
    func initGame() {
        var player : PlayerCharacter = Player.instance
        
        var room0 : Room = WorldRoom()
        var room1 : Room = WorldRoom()
        var room2 : Room = WorldRoom()
        let portalA : Entity = EntityFactory.createEntityWithPortal(to: room1)
        let portalB : Entity = EntityFactory.createEntityWithPortal(to: room0)
        let portalC : Entity = EntityFactory.createEntityWithPortal(to: room2)
        
        room0.entities.append(portalA)
        room0.entities.append(portalC)
        room1.entities.append(portalB)
        room2.entities.append(portalB)
        
        player.currentLocation = room0
        
        portalA.portal?.addListener(self)
        portalB.portal?.addListener(self)
    }
    
    func playerUsed(#portal: Portal, to room: Room) {
        var player = Player.instance
        player.currentLocation = room
        refreshDisplay()
    }
    
}
