//
//  GameScene.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class TitleScene: BaseScene {
    
    var titleNode : SKLabelNode!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let playScene : PlayScene = PlayScene()
        let view : SKView = self.view!
        view.presentScene(playScene)
    }
    
    override func createSceneContents() -> Void
    {
        super.createSceneContents()
        self.createHelloNode()
    }
    
    func createHelloNode() -> Void
    {
        self.titleNode = SKLabelNode(fontNamed: StyleGuide.font())
        let touchToStartNode : SKLabelNode = SKLabelNode(fontNamed: StyleGuide.font())
        
        titleNode.text = "TextRPG"
        titleNode.fontSize = StyleGuide.titleFontSize()
        
        touchToStartNode.text = "Touch to Start"
        touchToStartNode.fontSize = StyleGuide.subtitleFontSize()
        
        titleNode.addChild(touchToStartNode)
        
        let pos = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        titleNode.position = pos
        touchToStartNode.position = CGPointMake(0, -50)
        
        self.addChild(self.titleNode)
    }
}
