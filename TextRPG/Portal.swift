//
//  Portal.swift
//  TextRPG
//
//  Created by Todd Greener on 4/24/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol PortalListener : class {
    func playerUsed(#portal: Portal, to room: Room) -> Void
}

protocol Portal {
    func addListener(listener: PortalListener) -> Void
    func traverse() -> Void
    var targetRoom : Room { get }
}

class GamePortal : Portal {
    let targetRoom : Room
    let notifier : Notifier<PortalListener> = Notifier<PortalListener>()
    
    init(to room: Room) {
        self.targetRoom = room
    }
    
    func addListener(listener: PortalListener) {
        notifier.addListener(listener)
    }
    
    func traverse() {
        notifier.notify({ listener in listener.playerUsed(portal:self, to: self.targetRoom) })
    }
}
