//
//  PlayScene.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class PlayScene: BaseScene {
    
    override func createSceneContents() {
        super.createSceneContents()
        addChild(TextDisplay(at: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))));
    }
    
}
