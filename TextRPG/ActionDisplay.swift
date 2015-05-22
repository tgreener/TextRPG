//
//  ActionDisplay.swift
//  TextRPG
//
//  Created by Todd Greener on 5/13/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class ActionDisplay : TextDisplay {
    
    init(touchHandler: TouchHandler, containingDisplay : TextDisplay) {
        super.init(at: CGPoint.zeroPoint, size: CGSizeMake(containingDisplay.size.width - StyleGuide.elementMargin() * 2, StyleGuide.actionButtonTextSize()))
        self.touchHandler = touchHandler
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
