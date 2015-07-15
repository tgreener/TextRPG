//
//  Location.swift
//  TextRPG
//
//  Created by Todd Greener on 6/8/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol Location {
    var currentLocation : Room! { get set }
}

class LocationComponent : Location {
    weak var currentLocation : Room! = nil
}
