//
//  TextDisplay.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

class TextDisplay : SKNode {
    
    let borderNode : SKShapeNode = SKShapeNode()
    let textAnchorNode : SKNode = SKNode()
    var textNodes  : [SKLabelNode] = [SKLabelNode]()
    
    var text : String {
        set {
            set(text: newValue)
        }
        get {
            return getText()
        }
    }
    
    var size : CGSize = CGSizeMake(0, 0) {
        didSet {
            self.textAnchorNode.position = CGPointMake(-self.size.width / 2 + StyleGuide.textDisplayPadding(), self.size.height / 2 - lineHeight)
        }
    }
    
    var lineHeight : CGFloat = StyleGuide.titleFontSize()
    
    init(at point: CGPoint) {
        super.init()
        self.position = point
        self.addChild(borderNode)
        self.addChild(textAnchorNode)
    }
    
    func calcBorder() {
        var borderPath = CGPathCreateMutable()
        CGPathMoveToPoint(borderPath, nil, 0, 0)
        CGPathAddRoundedRect(borderPath, nil, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), 0, 0)
        
        borderNode.path = borderPath
        borderNode.strokeColor = StyleGuide.actionButtonTextColor()
        borderNode.lineWidth = 2
    }
    
    func createLabelNode() -> SKLabelNode {
        let label = SKLabelNode()
        
        label.fontColor = StyleGuide.descriptiveTextColor()
        label.fontSize = StyleGuide.titleFontSize()
        label.fontName = StyleGuide.font()
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        return label
    }
    
    func set(#text: String) -> Void {
       
        func findNearestWhitespaceSplit(to i: String.Index, given str: String) -> String.Index {
            
            let whiteSet = NSCharacterSet.whitespaceCharacterSet()
            
            var index = i
            for ; index != str.startIndex; index = index.predecessor() {
                let s = String(str[index])
                let ix = s.startIndex
                let ix2 = s.endIndex
                let result = s.rangeOfCharacterFromSet(whiteSet, options: nil, range: ix..<ix2)
                let isWhiteSpace = result != nil
                
                if isWhiteSpace { break }
            }
            
            return index
        }
        
        for label in textNodes {
            label.removeFromParent()
        }
        textNodes.removeAll(keepCapacity: false)
        
        var label : SKLabelNode = createLabelNode()
        var anotherLabel = createLabelNode()
        label.text = text
        textNodes.append(label)

        while (label.frame.width >  self.size.width - StyleGuide.textDisplayPadding()) && (self.size.width > 0) {
            let ratio : Float = Float(self.size.width) / Float(label.frame.width)
            let index : String.Index = advance(label.text.startIndex, Int(ratio * Float(count(label.text))))
            var newIndex : String.Index = findNearestWhitespaceSplit(to: index, given: label.text)
            
            var stringBeforeBreak = label.text.substringToIndex(newIndex)
            stringBeforeBreak = stringBeforeBreak.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            var stringAfterBreak = label.text.substringFromIndex(newIndex)
            stringAfterBreak = stringAfterBreak.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            if equal(label.text, stringBeforeBreak) { break }
            
            label.text = stringBeforeBreak
            
            anotherLabel = createLabelNode()
            anotherLabel.text = stringAfterBreak
            textNodes.append(anotherLabel)
            
            label = anotherLabel
        }
        
        
        for var i : Int = 0; i < textNodes.count; i++ {
            let pos = CGPointMake(0, self.lineHeight * CGFloat(i) * -1)
            textNodes[i].position = pos
            
            textAnchorNode.addChild(textNodes[i])
        }
        
        calcBorder()
    }
    
    func getText() -> String {
        var result = ""
        var isFirst = true
        
        for label in textNodes {
            if isFirst {
                isFirst = false
            }
            else {
                result += " "
            }
            result += label.text
        }
        
        return result
    }
    

    
    override func containsPoint(p: CGPoint) -> Bool {
        return borderNode.containsPoint(p);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
