//
//  PickUp.swift
//  TextRPG
//
//  Created by Todd Greener on 5/13/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol PickUpListener {
    func picked(up item: Entity, by player: PlayerCharacter, from container: EntityContainer)
}

protocol PickUp {
    var name        : String { get }
    var description : String { get }
    var entity : Entity! { get set }
    var container : EntityContainer! { get set }
    
    func addListener(listener: PickUpListener) -> Void
    func pickUp(andGiveTo player: PlayerCharacter) -> Void
}

class PickUpItem : PickUp {
    var name        : String = ""
    var description : String = ""
    
    let notifier : Notifier<PickUpListener> = Notifier<PickUpListener>()
    weak var entity : Entity!
    weak var container : EntityContainer! = nil
    
    init(name : String, description: String) {
        self.name = name
        self.description = description
    }
    
    func addListener(listener: PickUpListener) {
        notifier.addListener(listener)
    }
    
    func pickUp(andGiveTo player: PlayerCharacter) {
        notifier.notify({listener in listener.picked(up: self.entity, by: player, from: self.container)})
    }
}

