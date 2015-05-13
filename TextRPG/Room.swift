//
//  Room.swift
//  TextRPG
//
//  Created by Todd Greener on 4/24/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

protocol Room {
    var name : String { get }
    var description : String { get }
    var entities : [Entity] { get set }
}

class WorldRoom : Room {
    static var roomCounter : Int = 0
    let roomNumber : Int
    
    var entities : [Entity] = [Entity]()
    
    var name : String {
        return "room \(self.roomNumber)"
    }
    
    var description : String {
        get {
            var result : String = self.name + "."
            for entity : Entity in entities {
                result += " There is \(entity.description)."
            }
            
            return result
        }
    }
    
    init() {
        roomNumber = WorldRoom.roomCounter
        WorldRoom.roomCounter++
    }
}
