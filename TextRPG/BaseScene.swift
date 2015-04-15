//
//  BaseScene.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class BaseScene : SKScene {
    var contentCreated : Bool = false
    
    override func didMoveToView(view: SKView) -> Void
    {
        if !self.contentCreated
        {
            self.backgroundColor = SKColor.grayColor()
            self.scaleMode = .AspectFit
            self.size = self.view!.frame.size
            self.createSceneContents()
        }
    }
    
    func createSceneContents() {
        self.contentCreated = true
    }
    
}
