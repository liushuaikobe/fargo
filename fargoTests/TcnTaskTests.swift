//
//  TcnTaskTests.swift
//  fargo
//
//  Created by Shuai Liu on 16/1/11.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import Foundation
import XCTest
@testable import fargo

class TcnTaskTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFargo() {
        let expectation = self.expectationWithDescription("Fargo Successfully")
        
        TcnFargoTask().shorten("http://www.google.com/").success {
            url, result in
            
            XCTAssertEqual(url, "http://www.google.com/")
            XCTAssertEqual(result, "http://t.cn/h5ef4")
            
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