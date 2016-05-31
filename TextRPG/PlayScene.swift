//
//  PlayScene.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class PlayScene: BaseScene {
    
    var display : TextDisplay! = nil
    var actionBox : TextDisplay! = nil
    var inventoryBox : TextDisplay! = nil
    var infoBox : TextDisplay! = nil
    
    var actionDisplays: [ActionDisplay] =  [ActionDisplay]()
    var inventoryDisplays: [TextDisplay] = [TextDisplay]()

    var world : World!
    
    override func createSceneContents() {
        super.createSceneContents()
        
        world = World()
        self.backgroundColor = StyleGuide.defaultBackgroundColor()
        let bothSideMargin : CGFloat = StyleGuide.elementMargin() * 2
        let mainBoxWidth : CGFloat = self.frame.width - StyleGuide.elementMargin() * 2
        
        func getDisplayHeightFromFactor(factor: CGFloat) -> CGFloat {
            return (self.frame.height * factor) - bothSideMargin;
        }
        
        let infoBoxSize = CGSizeMake(mainBoxWidth, getDisplayHeightFromFactor(1 / 12))
        infoBox = TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - StyleGuide.elementMargin()), size: infoBoxSize)
        infoBox.fontSize = StyleGuide.subtitleFontSize()
        addChild(infoBox)
        
        let displaySize = CGSizeMake(mainBoxWidth, getDisplayHeightFromFactor(6 / 12))
        display = TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(infoBox.frame) - StyleGuide.elementMargin()), size: displaySize)
        addChild(display)

        let actionBoxSize = CGSizeMake(mainBoxWidth, getDisplayHeightFromFactor(3 / 12))
        actionBox = TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(display.frame) - StyleGuide.elementMargin()), size: actionBoxSize)
        addChild(actionBox)
        
        let inventoryBoxSize = CGSizeMake(mainBoxWidth, getDisplayHeightFromFactor(2 / 12))
        inventoryBox = TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(actionBox.frame) - StyleGuide.elementMargin()), size: inventoryBoxSize)
        addChild(inventoryBox)
        
        refreshDisplay()
    }
    
    func refreshDisplay() {
        display.text = "You are currently in \(Player.instance.currentLocation.description)"
        infoBox.text = world.clock.toString()
        refreshActionDisplays()
        refreshInventoryDisplay()
    }
    
    func refreshInventoryDisplay() {
        clearInventoryDisplay()
        let inventory : EntityContainer = Player.instance.inventory as! EntityContainer
        
        for entity in inventory.entities {
            let itemDisplay : TextDisplay = TextDisplay(at: CGPoint.zero, size: CGSizeMake(100, self.inventoryBox.frame.height - StyleGuide.elementMargin() * 2))
            itemDisplay.text = entity.pickUp!.name
            itemDisplay.anchorPoint = CGPoint.zero
            inventoryDisplays.append(itemDisplay)
        }
        
        for i : Int in 0 ..< inventoryDisplays.count {
            let xPos : CGFloat = (-inventoryBox.frame.width / 2) + (StyleGuide.elementMargin() + (inventoryDisplays[i].size.width * CGFloat(i)))
            let yPos : CGFloat = -StyleGuide.elementMargin()
            inventoryDisplays[i].anchorPoint = CGPoint(x: 0, y: 1)
            inventoryDisplays[i].position = CGPoint(x: xPos, y: yPos)
            inventoryBox.addChild(inventoryDisplays[i])
        }
    }
    
    func clearInventoryDisplay() {
        for item in inventoryDisplays {
            item.removeFromParent()
        }
        
        inventoryDisplays.removeAll(keepCapacity: false)
    }
    
    func refreshActionDisplays() {
        clearActionDisplays()
        func createDefaultTouchHandler(timeStep t: WorldTime, customHandler : TouchHandler) -> TouchHandler {
            return {
                customHandler()
                self.world.runSimulation(t)
                self.refreshDisplay()
            }
        }
        
        let currentRoom : Room = Player.instance.currentLocation
        for entity in currentRoom.entities {
            for action in entity.actions {
                let handler : TouchHandler = createDefaultTouchHandler(timeStep: action.duration) {
                    action.enqueueCommand(from: Player.instance)
                }
                let actionDisplay : ActionDisplay = ActionDisplay(touchHandler: handler, containingDisplay: actionBox)
                actionDisplay.text = action.actionText
                actionDisplay.durationLabel.text = String(format: "%.02fs", arguments: [action.duration])
                actionDisplays.append(actionDisplay)
            }
        }
        
        for i : Int in 0 ..< actionDisplays.count {
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
}
