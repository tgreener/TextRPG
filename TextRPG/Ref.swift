//
//  Ref.swift
//  TextRPG
//
//  Created by Todd Greener on 7/15/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

class Ref<T> {
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}
