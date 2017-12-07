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
        let testValue1: Output = Output(completeMatrixPath: true, costOfPath: 10, pathArray: [1,2,3,1,0]);
        XCTAssert(testValue1.latestPath()==0,"The Supplied Output instanse has last path value as 0");
        let testValue2: Output = Output(completeMatrixPath: true, costOfPath: 10, pathArray: [1,2,3,1,2]);
        XCTAssert(testValue2.latestPath()==2,"The Supplied Output instanse has last path value as 2");

    }
    func testOutputStaticFunctionForFindingLeastCostPath()
    {
        let a:Output = Output(completeMatrixPath: false, costOfPath: 31, pathArray: [0,2]);
        let b:Output = Output(completeMatrixPath: false, costOfPath: 49, pathArray: [0,0,2]);
        let c:Output = Output(completeMatrixPath: false, costOfPath: 48, pathArray: [0,0,0]);
        let returnValue:Output = Output.chooseLeastCostPathWithMiximumTraversedPoint(upperDigonal: a, sameLine: b, lowerDigonal: c);
        XCTAssert(returnValue === c, "The c output value is the Least cost path with maximum traverse point");
    }
    
    
}
