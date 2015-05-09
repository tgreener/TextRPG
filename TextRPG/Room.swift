//
//  Room.swift
//  TextRPG
//
//  Created by Todd Greener on 4/24/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import SpriteKit

protocol Room {
    var description : String { get }
    var entities : [Entity] { get set }
}

class WorldRoom : Room {
    static var roomCounter : Int = 0
    let roomNumber : Int
    
    var entities : [Entity] = [Entity]()
    
    var description : String {
        get {
            return "room \(self.roomNumber)"
        }
    }
    
    init() {
        roomNumber = WorldRoom.roomCounter
        WorldRoom.roomCounter++
    }
}
