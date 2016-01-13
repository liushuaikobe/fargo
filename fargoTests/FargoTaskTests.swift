//
//  FargoTaskTests.swift
//  fargo
//
//  Created by Shuai Liu on 16/1/8.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import Foundation
import XCTest
@testable import fargo

class FargoTaskTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildParams() {
        let task = FargoTask()
        
        XCTAssertEqual(task.buildQuery(["para1": "ha ha"]), "?para1=ha%20ha")
        XCTAssertEqual(task.buildQuery(["kobe": "shuai"]), "?kobe=shuai")
        
        let r = task.buildQuery(["para1": "ha", "para2": "world"])
        XCTAssert(r == "?para1=ha&para2=world" || r == "?para2=world&para1=ha")
        
        XCTAssertEqual(task.buildQuery(["": ""]), "")
    }
    
}