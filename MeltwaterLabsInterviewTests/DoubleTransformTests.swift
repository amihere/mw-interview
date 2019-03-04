//
//  DoubleTransformTests.swift
//  MeltwaterLabsInterviewTests
//
//  Created by Ayeba Amihere on 04/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import XCTest
@testable import MeltwaterLabsInterview

class DoubleTransformTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFormatPoints(){
        var number:Double = 1000000
        var expectedValue = "1M"
        var message:String{
            return "\(number) != \(expectedValue)"
        }
        
        XCTAssert(Double.formatPoints(num: number) == expectedValue, message)
        
        number = 2000000
        expectedValue = "2M"
        XCTAssert(Double.formatPoints(num: number) == expectedValue, message)
        
        number = 2300000
        expectedValue = "2.3M"
        XCTAssert(Double.formatPoints(num: number) == expectedValue, message)
        
    }
}
