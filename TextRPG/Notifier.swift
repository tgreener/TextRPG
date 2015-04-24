//
//  Notifier.swift
//  TextRPG
//
//  Created by Todd Greener on 4/19/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//


import Foundation

class Notifier<ListenerType : AnyObject> {
    var listeners : [NotifierListenerWrapper<ListenerType>] = [NotifierListenerWrapper<ListenerType>]()
    
    func addListener(listener: ListenerType) {
        listeners.append(NotifierListenerWrapper<ListenerType>(value: listener))
    }
    
    func notify(closure: (ListenerType) -> Void) {
        for listener in listeners {
            closure(listener.value)
        }
    }
}

class NotifierListenerWrapper<ListenerType : AnyObject> {
    unowned let value : ListenerType // TODO: Use this once the compiler is updated. The unowned and AnyObject parts throw it for a loop (figuratively).
    init(value: ListenerType) {
        self.value = value
    }
}
