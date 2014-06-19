//
//  Book.swift
//  TestSwift
//
//  Created by Jason Li on 6/4/14.
//  Copyright (c) 2014 swift. All rights reserved.
//

import Foundation

class Book : NSObject {
    
    var title:String
    
    init() {
        self.title = "Swift Book"
    }
    
    func log() {
        println("I am \(self.title)")
    }
    
}