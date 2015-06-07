//
//  PickUp.swift
//  TextRPG
//
//  Created by Todd Greener on 5/13/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol PickUpListener {
    func picked(up item: Entity, by entity: Entity, from container: EntityContainer)
}

protocol PickUp : Action {
    var name        : String { get }
    var description : String { get }
    var entity : Entity! { get set }
    var container : EntityContainer! { get set }
    
    func addListener(listener: PickUpListener) -> Void
    func pickUp(andGiveTo entity: Entity) -> Void
}

class PickUpItem : PickUp {
    var name        : String = ""
    var description : String = ""
    var actionText  : String {
        get {
            return "Pick up \(description)"
        }
    }
    
    let duration : WorldTime
    
    let notifier : Notifier<PickUpListener> = Notifier<PickUpListener>()
    weak var entity : Entity!
    weak var container : EntityContainer! = nil
    
    init(name : String, description: String, duration: WorldTime) {
        self.name = name
        self.description = description
        self.duration = duration
    }
    
    func addListener(listener: PickUpListener) {
        notifier.addListener(listener)
    }
    
    func pickUp(andGiveTo entity: Entity) {
        let oldContainer = self.container
        entity.inventory?.insert(self.entity)
        
        oldContainer.entities = oldContainer.entities.filter{
            e in return e !== self.entity
        }
        
        notifier.notify({listener in listener.picked(up: self.entity, by: entity, from: self.container)})
    }
    
    func enqueueCommand(from actor: Entity) {
        Commander.instance.submitCommand {
            self.pickUp(andGiveTo: actor)
        }
    }
}

