//
//  TextDisplay.swift
//  TextRPG
//
//  Created by Todd Greener on 4/14/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

typealias TouchHandler = ()->Void

class TextDisplay : SKSpriteNode {
    
    let borderNode : SKShapeNode = SKShapeNode()
    let textAnchorNode : SKNode = SKNode()
    var textNodes  : [SKLabelNode] = [SKLabelNode]()
    var touchHandler : (() -> Void)! = nil {
        didSet {
            if touchHandler != nil {
                self.userInteractionEnabled = true
            }
            else {
                self.userInteractionEnabled = false
            }
        }
    }

    var text : String {
        set {
            set(text: newValue)
        }
        get {
            return getText()
        }
    }
    
    override var size : CGSize  {
        didSet {
            calcBorder()
            set(text: getText())
        }
    }
    
    override var anchorPoint : CGPoint {
        didSet {
            calcBorder()
        }
    }
    
    var contentWidth : CGFloat {
        get {
            return self.size.width - (StyleGuide.textDisplayPadding() * 2)
        }
    }
    
    var lineHeight : CGFloat = StyleGuide.descriptiveTextSize()
    
    init(at position: CGPoint, size: CGSize) {
        super.init(texture:nil, color: StyleGuide.defaultBackgroundColor(), size: size)
        self.anchorPoint = CGPoint(x: 0.5, y: 1)
        self.position = position
        self.addChild(borderNode)
        self.addChild(textAnchorNode)
        calcBorder()
    }
    
    func calcBorder() {
        var borderPath = CGPathCreateMutable()
        CGPathMoveToPoint(borderPath, nil, 0, 0)
        CGPathAddRoundedRect(borderPath, nil, CGRectMake(-self.size.width * self.anchorPoint.x, -self.size.height * self.anchorPoint.y, self.size.width, self.size.height), 2, 2)
        
        borderNode.path = borderPath
        borderNode.strokeColor = StyleGuide.actionButtonTextColor()
        borderNode.lineWidth = StyleGuide.borderStrokeWidth()
        
        self.textAnchorNode.position = CGPointMake(-self.size.width * self.anchorPoint.x + StyleGuide.textDisplayPadding(), self.size.height * (1-self.anchorPoint.y) - lineHeight)
    }
    
    func createLabelNode() -> SKLabelNode {
        let label = SKLabelNode()
        
        label.fontColor = StyleGuide.descriptiveTextColor()
        label.fontSize = StyleGuide.descriptiveTextSize()
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

        while (label.frame.width >  self.contentWidth) && (self.size.width > 0) {
            let ratio : Float = Float(self.contentWidth) / Float(label.frame.width)
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = (touches as! Set<UITouch>).first
        
        if touch == nil {
            CGPoint(x: CGRectGetMidX(self.frame)*0.5, y: CGRectGetMidY(self.frame)*1.5)
            return
        }
        
        let touchPoint = touch!.locationInNode(borderNode)
        if borderNode.containsPoint(touchPoint) {
            self.touchHandler()
        }
        else {
            super.touchesBegan(touches, withEvent: event)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
