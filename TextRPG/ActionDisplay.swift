//
//  ActionDisplay.swift
//  TextRPG
//
//  Created by Todd Greener on 5/13/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class ActionDisplay : TextDisplay {
    
    let durationAnchorNode : SKNode
    let durationLabel : SKLabelNode
    
    init(touchHandler: TouchHandler, containingDisplay : TextDisplay) {
        self.durationAnchorNode = SKNode()
        self.durationLabel = SKLabelNode()
        super.init(at: CGPoint.zeroPoint, size: CGSizeMake(containingDisplay.size.width - StyleGuide.elementMargin() * 2, StyleGuide.actionButtonTextSize()))
        self.touchHandler = touchHandler
        
        self.durationLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        self.durationLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        self.durationLabel.fontColor = StyleGuide.descriptiveTextColor()
        self.durationLabel.fontSize = self.fontSize
        self.durationLabel.fontName = StyleGuide.font()
        
        self.durationAnchorNode.position = CGPoint(x: (self.size.width / 2) - StyleGuide.textDisplayPadding(), y: -StyleGuide.textDisplayPadding())
        addChild(self.durationAnchorNode)
        self.durationAnchorNode.addChild(self.durationLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
