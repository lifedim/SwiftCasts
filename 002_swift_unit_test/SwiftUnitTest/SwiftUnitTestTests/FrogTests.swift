//
//  FrogTests.swift
//  SwiftUnitTest
//
//  Created by Jason Li on 6/20/14.
//  Copyright (c) 2014 Swiftist. All rights reserved.
//

import XCTest
import SwiftUnitTest

class FrogTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFrogTransformation() {
        
        let frog = Frog()
        frog.transform()
        
        XCTAssert(frog.name == "Frog", "Pass")
        
    }

    func testPerformanceExample() {
        self.measureBlock() {
            var sum:Double = 0
            for i in 1..1000000 {
                sum += Double(i)
            }
        }
    }

}
