//
//  NetworkInteractionTests.swift
//  MeltwaterLabsInterviewTests
//
//  Created by Ayeba Amihere on 04/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import XCTest
@testable import MeltwaterLabsInterview

class NetworkInteractionTests: XCTestCase {
    var url:URL!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        url = URL(string: "https://api.jsonbin.io/b/5c7c81e75fe214587794e985")!
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetWithInvalidJSON() {
        let expectation = self.expectation(description: "Network: Invalid JSON")
        var response = String()
        
        NetworkInteraction.get(url: url) { (result:Result<String>) in
            switch result {
            case .failure(_):
                break
            case .success(let text):
                response = text
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(response.isEmpty)
    }
    
    func testGetWithValidJSON() {
        let expectation = self.expectation(description: "Network: Valid JSON")
        var response:FunnyData!
        
        struct FunnyData: Codable{
            var ko:String?
        }
        
        NetworkInteraction.get(url: url) { (result:Result<FunnyData>) in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let data):
                response = data
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(response.ko == "ka")
    }
}
