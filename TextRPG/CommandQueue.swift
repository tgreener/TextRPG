//
//  CommandQueue.swift
//  TextRPG
//
//  Created by Todd Greener on 5/13/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

typealias Command = ()->Void

protocol CommandQueue {
    static var instance : CommandQueue { get }
    func submitCommand(command:() -> Void)
    func runCommands() -> Void
}

class Commander : CommandQueue {
    static let instance : CommandQueue = Commander()    
    
    var commands : [Command] = [Command]()
    
    init() {
        
    }
    
    func submitCommand(command: Command) {
        commands.append(command)
    }
    
    func runCommands() {
        for command in commands { command() }
        commands.removeAll(keepCapacity: false)
    }
    
}
