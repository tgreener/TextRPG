//
//  Portal.swift
//  TextRPG
//
//  Created by Todd Greener on 4/24/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol PortalListener : class {
    func entity(entity: Entity, used portal: Portal, to room: Room) -> Void
}

protocol Portal : Action {
    func addListener(listener: PortalListener) -> Void
    func traverse(actor: Entity) -> Void
    var targetRoom : Room { get }
}

class GamePortal : Portal {
    let targetRoom : Room
    let notifier : Notifier<PortalListener> = Notifier<PortalListener>()
    let duration : WorldTime
    var actionText : String {
        get {
            return "Go to \(targetRoom.name)"
        }
    }
    
    init(to room: Room, duration: WorldTime) {
        self.targetRoom = room
        self.duration = duration
    }
    
    func addListener(listener: PortalListener) {
        notifier.addListener(listener)
    }
    
    func traverse(actor: Entity) {
        notifier.notify({ listener in listener.entity(actor, used:self, to: self.targetRoom) })
    }
    
    func enqueueCommand(from actor: Entity) {
        Commander.instance.submitCommand {
            self.traverse(actor)
        }
    }
}
