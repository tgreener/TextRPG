//
//  PlayScene.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class PlayScene: BaseScene, PortalListener, PickUpListener {
    
    var display : TextDisplay! = nil
    var actionBox : TextDisplay! = nil
    var actionDisplays: [ActionDisplay] = [ActionDisplay]()
    var rooms : [Room] = [Room]()
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        print("touched")
    }
    
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
        
        func createDefaultTouchHandler(timeStep t: WorldTime, command : Command) -> Command{
            return {
                Commander.instance.submitCommand(command)
                self.runSimulation(t)
            }
        }
        
        var currentRoom : Room = Player.instance.currentLocation
        for entity in currentRoom.entities {
            if let p = entity.portal {
                let handler : TouchHandler = createDefaultTouchHandler(timeStep: 0.0) {
                    p.traverse()
                }
                
                let portalDisplay : ActionDisplay = ActionDisplay(touchHandler: handler, containingDisplay: actionBox)
                portalDisplay.text = "Take portal to \(p.targetRoom.name)"
                actionDisplays.append(portalDisplay)
            }
            
            if let pu : PickUp = entity.pickUp {
                let handler : TouchHandler = createDefaultTouchHandler(timeStep: 0.0) {
                    pu.pickUp(andGiveTo: Player.instance)
                }
                
                let pickUpDisplay : ActionDisplay = ActionDisplay(touchHandler: handler, containingDisplay: actionBox)
                pickUpDisplay.text = "Pick up \(pu.description)"
                actionDisplays.append(pickUpDisplay)
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
        
        actionDisplays.removeAll(keepCapacity: false)
    }
    
    func runSimulation(timeStep: WorldTime) {
        // Update all the things
        Commander.instance.runCommands()
        refreshDisplay()
    }
    
    func initGame() {
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
    
    func playerUsed(#portal: Portal, to room: Room) {
        var player = Player.instance
        player.currentLocation = room
    }
    
    func picked(up item: Entity, by player: PlayerCharacter, from container: EntityContainer) {
        container.entities = container.entities.filter{ entity in return entity !== item }
    }
}
