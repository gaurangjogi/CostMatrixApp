//
//  CostMatrixFrameworkTests.swift
//  CostMatrixFrameworkTests
//
//  Created by Gaurang Jogi on 06/12/17.
//  Copyright © 2017 Gaurang Jogi. All rights reserved.
//

import XCTest
@testable import CostMatrixFramework

class MatrixTestSuite: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMatrixCreation()
    {
        /*
         Testing creation of Cost matrix.
         */
        let matrix:Matrix =  Matrix(rows: 3, columns: 4, maximumCostValueForPath: 10);
        XCTAssert(matrix.numberOfRows==3 && matrix.numberOfColumns==4 && matrix.maximumCostValueForPath==10, "The matrix should have 3 rows, 4 column and maximumCostValueForPath 10");
        XCTAssert(matrix.costArray[2][3]==0, "All values of cost matrix should be zero on intialization");
    }
    
    func testSixCrossFiveNormalFlowMatrix()
    {
        let matrix:Matrix = Matrix(rows:5,columns:6);
        matrix.costArray = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,8,6,4]];
        var result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 16 && result.pathArray == [1,2,3,4,4,5], "The applied matrix path is complete and minimum Cost of path is 16");
        
        matrix.costArray = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,1,2,3]];
        result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 11 && result.pathArray == [1,2,1,5,4,5], "The applied matrix path is complete and minimum Cost of path is 11");
    }
    
    func testFiveCrossThreeWithNoPathLessThen50()
    {
        let matrix:Matrix = Matrix(rows:3,columns:5);
        matrix.costArray = [[19,10,19,10,19],[21,23,20,19,12],[20,12,20,11,10]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == false && result.costOfPath == 48 && result.pathArray == [1,1,1], "The applied matrix path is incomplete with no path less than 50");
    }
    
    func testOneCrossFiveCostMatrix()
    {
        let matrix:Matrix = Matrix(rows:1,columns:5);
        matrix.costArray = [[5,8,5,3,5]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 26 && result.pathArray == [1,1,1,1,1], "The applied matrix path is complete with minimum cost of path is 26");
    }
    
    func testFiveCrossOneCostMatrix()
    {
        let matrix:Matrix = Matrix(rows:5,columns:1);
        matrix.costArray = [[5],[8],[5],[3],[5]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 3 && result.pathArray == [4], "The applied matrix path is complete with minimum cost of path is 3");
    }
    
    func testThreeCrossFiveCostMatrixWithStartingCostValueGreaterThen50()
    {
        let matrix:Matrix = Matrix(rows:3,columns:5);
        matrix.costArray = [[69,10,19,10,19],[51,23,20,19,12],[60,12,20,11,10]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == false && result.costOfPath == 0 && result.pathArray == [], "The applied matrix path is incomplete with no minimum cost of path");
    }
    
    func testThreeCrossFourCostMatrixWithOneValueCostValueGreaterThen50()
    {
        let matrix:Matrix = Matrix(rows:3,columns:4);
        matrix.costArray = [[60,3,3,6],[6,3,7,9],[5,6,8,3]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 14 && result.pathArray == [3,2,1,3], "The applied matrix path is complete with minimum cost of path 14");
    }
    
    func testFourCrossFourCostMatrixWithNegativeValues()
    {
        let matrix:Matrix = Matrix(rows:4,columns:4);
        matrix.costArray = [[6,3,-5,9],[-5,2,4,10],[3,-2,6,10],[6,-1,-2,10]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 0 && result.pathArray == [2,3,4,1], "The applied matrix path is complete with minimum cost of path 14");
    }
    
    func testFourCrossTwoCostMatrix ()
    {
        let matrix:Matrix = Matrix(rows:4,columns:2);
        matrix.costArray = [[51,51],[0,51],[51,51],[5,5]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 10 && result.pathArray == [4,4], "The applied matrix path is complete with minimum cost of path 14");
    }
    
    func testFourCrossThreeCostMatrix()
    {
        let matrix:Matrix = Matrix(rows:4,columns:3);
        matrix.costArray = [[51,51,51],[0,51,51],[51,51,51],[5,5,51]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == false && result.costOfPath == 10 && result.pathArray == [4,4], "The applied matrix path is incomplete with minimum cost of path 10");
    }
    
    func testTwoCrossTwentyCostMatrix()
    {
        let matrix:Matrix = Matrix(rows:2,columns:20);
        matrix.costArray = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 20 && result.pathArray == [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], "The applied matrix path is complete with minimum cost of path 10");
    }
    func testOneCrossTwentyCostMatrix()
    {
        let matrix:Matrix = Matrix(rows:1,columns:20);
        matrix.costArray = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];
        let result = matrix.evaluateCostMatrixForMinimumCost();
        XCTAssert(result.completeMatrixPath == true && result.costOfPath == 20 && result.pathArray == [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], "The applied matrix path is complete with minimum cost of path 10");
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
