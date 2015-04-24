//
//  TextDisplay.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class TextDisplay : SKLabelNode {
    
    let borderNode : SKShapeNode
    
    init(at point: CGPoint) {
        borderNode = SKShapeNode()
        super.init()
        
        self.fontName = StyleGuide.font()
        self.text = "TextDisplay"
        self.fontSize = StyleGuide.actionButtonTextSize()
        self.fontColor = StyleGuide.actionButtonTextColor()
        self.position = point
        
        var borderPath = CGPathCreateMutable()
        CGPathMoveToPoint(borderPath, nil, 0, 0)
        CGPathAddRoundedRect(borderPath, nil, CGRectMake(-self.frame.width / 2, -self.frame.height / 4.5, self.frame.size.width, self.frame.size.height), 10, 0)
        
        borderNode.path = borderPath
        borderNode.strokeColor = StyleGuide.actionButtonTextColor()
        borderNode.lineWidth = 2
        
        self.addChild(borderNode)
    }
    
    override func containsPoint(p: CGPoint) -> Bool {
        return borderNode.containsPoint(p);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
