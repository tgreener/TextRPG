//
//  StyleGuide.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class StyleGuide {
    static func font() -> String {
        return "Courier";
    }
    
    static func titleFontSize() -> CGFloat {
        return 65;
    }
    
    static func subtitleFontSize() -> CGFloat {
        return 35
    }
    
    static func actionButtonTextSize() -> CGFloat {
        return 48
    }
    
    static func actionButtonTextColor() -> SKColor {
        return SKColor.whiteColor()
    }
    
    static func descriptiveTextSize() -> CGFloat {
        return 16
    }
    
    static func descriptiveTextColor() -> SKColor {
        return SKColor.whiteColor()
    }
}
