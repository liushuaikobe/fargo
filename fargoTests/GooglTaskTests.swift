//
//  GooglTaskTests.swift
//  fargo
//
//  Created by Shuai Liu on 16/1/10.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import Foundation
import XCTest
@testable import fargo

class GooglTaskTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFargo() {
        
        let expectation = self.expectationWithDescription("Fargo Successfully")
        
        GooglFargoTask("AIzaSyBSwbXhKQFzeD7PKH1XLfHLQkjRZNkjo-k").shorten("http://www.google.com/").success {
            url, result in
            
            XCTAssertEqual(url, "http://www.google.com/")
            XCTAssertEqual(result, "http://goo.gl/fbsS")
            
            expectation.fulfill()
            
        }.error {
            error in
            
            
            
            expectation.fulfill()
        }.fargo()
        
        self.waitForExpectationsWithTimeout(15) {
            error in
        }
    }
    
}