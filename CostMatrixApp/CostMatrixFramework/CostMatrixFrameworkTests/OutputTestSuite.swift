//
//  OutputTestSuite.swift
//  CostMatrixFrameworkTests
//
//  Created by Gaurang Jogi on 07/12/17.
//  Copyright © 2017 Gaurang Jogi. All rights reserved.
//

import XCTest
@testable import CostMatrixFramework

class OutputTestSuite: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testOutputLatestPathValue()
    {
        let testValue1: Output = Output(completeMatrixPath: true, costOfPath: 10, pathArray: [1,2,3,1,0])
        XCTAssert(testValue1.latestPath()==0,"The Supplied Output instanse has last path value as 0")
        let testValue2: Output = Output(completeMatrixPath: true, costOfPath: 10, pathArray: [1,2,3,1,2])
        XCTAssert(testValue2.latestPath()==2,"The Supplied Output instanse has last path value as 2")
        
    }
    
    
    
}
