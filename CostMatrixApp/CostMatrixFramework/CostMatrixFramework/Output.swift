//
//  Output.swift
//  CostMatrixFramework
//
//  Created by Gaurang Jogi on 07/12/17.
//  Copyright © 2017 Gaurang Jogi. All rights reserved.
//

import UIKit

open class Output  {
    
    public var completeMatrixPath:Bool;
    public var costOfPath:Int;
    public var pathArray:[Int];
    init(completeMatrixPath:Bool,costOfPath:Int,pathArray:[Int]) {
        self.completeMatrixPath = completeMatrixPath;
        self.costOfPath = costOfPath;
        self.pathArray = pathArray;
    }
    final func latestPath () -> Int
    {
        if(self.pathArray.count == 0)
        {
            return -1;
        }
        else
        {
            return self.pathArray.last!;
        }
    }
    
    /*
     Least cost path finder static function.
     */
    static func chooseLeastCostPathWithMiximumTraversedPoint(upperDigonal:Output,sameLine:Output,lowerDigonal:Output) -> Output
    {
        var minimumValueOfAllPath = Swift.min(upperDigonal.completeMatrixPath==true ? upperDigonal.costOfPath : Int.max ,lowerDigonal.completeMatrixPath == true ? lowerDigonal.costOfPath : Int.max ,sameLine.completeMatrixPath == true ? sameLine.costOfPath : Int.max);
        
        /*
         If all the paths are not complete path then we need to choose the path which has maximum number of points traversed and minimum cost path value.
         */
        if(upperDigonal.completeMatrixPath == false && sameLine.completeMatrixPath == false && lowerDigonal.completeMatrixPath == false )
        {
            if(upperDigonal.pathArray.count == sameLine.pathArray.count && sameLine.pathArray.count == lowerDigonal.pathArray.count)
            {
                minimumValueOfAllPath = Swift.min(upperDigonal.costOfPath,lowerDigonal.costOfPath,sameLine.costOfPath)
            }
            else if(upperDigonal.pathArray.count == sameLine.pathArray.count && sameLine.pathArray.count > lowerDigonal.pathArray.count)
            {
                minimumValueOfAllPath = Swift.min(upperDigonal.costOfPath,sameLine.costOfPath)
            }
            else if(sameLine.pathArray.count == lowerDigonal.pathArray.count && lowerDigonal.pathArray.count > upperDigonal.pathArray.count)
            {
                minimumValueOfAllPath = Swift.min(lowerDigonal.costOfPath,sameLine.costOfPath)
                
            }
            else if(lowerDigonal.pathArray.count == upperDigonal.pathArray.count && upperDigonal.pathArray.count > sameLine.pathArray.count)
            {
                minimumValueOfAllPath = Swift.min(lowerDigonal.costOfPath,upperDigonal.costOfPath)
            }
            else if(upperDigonal.pathArray.count > sameLine.pathArray.count && upperDigonal.pathArray.count > lowerDigonal.pathArray.count)
            {
                minimumValueOfAllPath = upperDigonal.costOfPath;
            }
            else if(sameLine.pathArray.count > lowerDigonal.pathArray.count && sameLine.pathArray.count > upperDigonal.pathArray.count)
            {
                minimumValueOfAllPath = sameLine.costOfPath;
            }
            else if(lowerDigonal.pathArray.count > sameLine.pathArray.count && lowerDigonal.pathArray.count > upperDigonal.pathArray.count)
            {
                minimumValueOfAllPath = lowerDigonal.costOfPath;
            }
        }
        
        if(minimumValueOfAllPath == upperDigonal.costOfPath)
        {
            return upperDigonal;
        }
        else if(minimumValueOfAllPath == sameLine.costOfPath)
        {
            return sameLine;
        }
        else
        {
            return lowerDigonal;
        }
    }
}
