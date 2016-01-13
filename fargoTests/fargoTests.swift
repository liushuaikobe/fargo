//
//  fargoTests.swift
//  fargoTests
//
//  Created by Shuai Liu on 16/1/8.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import XCTest
@testable import fargo

class fargoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testURLParams() {
        let item_normal = NSURLQueryItem(name: "kobe", value: "brant")
        let item_space = NSURLQueryItem(name: "value", value: "haha haha")
        
        let comp = NSURLComponents()
        comp.queryItems = [item_normal, item_space]
        
        XCTAssertNotNil(comp.URL)
        XCTAssertEqual(comp.URL!.absoluteString, "?kobe=brant&value=haha%20haha")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
