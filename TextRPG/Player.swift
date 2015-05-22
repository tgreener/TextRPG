//
//  Player.swift
//  TextRPG
//
//  Created by Todd Greener on 5/4/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol PlayerCharacter {
    var currentLocation : Room! { get set }
}

class Player : Entity, PlayerCharacter {
    var currentLocation : Room! = nil {
        willSet(newLocation) {
            
        }
        didSet(oldLocation) {
            
        }
    }
    static let instance : PlayerCharacter = Player(portalComponent: nil, pickUpComponent: nil)
}
