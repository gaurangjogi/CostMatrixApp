//
//  Output.swift
//  CostMatrixFramework
//
//  Created by Gaurang Jogi on 07/12/17.
//  Copyright © 2017 Gaurang Jogi. All rights reserved.
//

import UIKit

open class Output  {
    
    public var completeMatrixPath:Bool
    public var costOfPath:Int
    public var pathArray:[Int]
    
    init(completeMatrixPath:Bool,costOfPath:Int,pathArray:[Int]) {
        self.completeMatrixPath = completeMatrixPath
        self.costOfPath = costOfPath
        self.pathArray = pathArray
    }
    final func latestPath () -> Int
    {
        if(self.pathArray.count == 0)
        {
            return -1
        }
        else
        {
            return self.pathArray.last!
        }
    }
    
    /*
     Least cost path finder static function.
     */
    static func chooseLeastCostPathWithMiximumTraversedPoint(upperDigonal:Output,sameLine:Output,lowerDigonal:Output) -> Output
    {

        let minimumValueOfAllPath =  Swift.min(upperDigonal.costOfPath,sameLine.costOfPath, lowerDigonal.costOfPath)
        if(minimumValueOfAllPath == upperDigonal.costOfPath)
        {
            return upperDigonal
        }
        else if(minimumValueOfAllPath == sameLine.costOfPath)
        {
            return sameLine
        }
        else
        {
            return lowerDigonal
        }
    }
    final func reducePreviousPath(column:Int,fromMatrix:[[Int]]) -> Output
    {
        let newPath:Output = Output(completeMatrixPath: self.completeMatrixPath, costOfPath: self.costOfPath, pathArray: self.pathArray)
        for i in 0..<column
        {
            newPath.costOfPath = newPath.costOfPath - fromMatrix[self.pathArray[i]][i]
            newPath.pathArray.remove(at: 0)
        }
        return newPath
    }
}
