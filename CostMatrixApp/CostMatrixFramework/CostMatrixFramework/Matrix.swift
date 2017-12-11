//
//  Matrix.swift
//  CostMatrixFramework
//
//  Created by Gaurang Jogi on 06/12/17.
//  Copyright © 2017 Gaurang Jogi. All rights reserved.
//

import UIKit

open class Matrix {
    
    /*
     To define number of rows in matrix
     */
    var numberOfRows:Int
    /*
     To define number of columns in Matrix
     */
    var numberOfColumns:Int
    /*
     To define the maximum cost value of path when encountered we stop finding path the default value of the this we will set as 50.
     */
    var maximumCostValueForPath:Int
    
    /*
     Cost Values two dimentional array
     */
    var costArray:[[Int]] 
    
    /*
     initializer for creating the cost matrix
     */
    
    var alreadySearchedPath:[Output]?
    
    public init(rows:Int, columns:Int, maximumCostValueForPath:Int=50) {
        self.numberOfRows = rows
        self.numberOfColumns = columns
        self.maximumCostValueForPath = maximumCostValueForPath
        self.costArray = Array(repeating: Array(repeating: 0,count:self.numberOfColumns),count:self.numberOfRows)
    }
    
    public final func assignMatrixValueAt(row:Int,column:Int,cost:Int) -> Void
    {
        if(row >= 0 && row < self.numberOfRows && column >= 0 && column < self.numberOfColumns)
        {
            self.costArray[row][column] = cost
        }
    }
    /*
     If the matrix has single column then we just need to find out minimum of all the numbers in the
     */
    final func oneColumnMatrixEvalution() -> Output
    {
        var rowNumber:Int = 0
        var costOfPoint:Int = self.costArray[0][0]
        for i in 1..<numberOfRows
        {
            if(self.costArray[i][0] < costOfPoint )
            {
                rowNumber = i
                costOfPoint = self.costArray[i][0]
            }
        }
        
     
        
        return Output(completeMatrixPath: true, costOfPath: costOfPoint, pathArray: [rowNumber])
    }
    
    /*
     Evaluates Cost matrix for minimum cost path
     */
    public final func evaluateCostMatrixForMinimumCost() -> Output {
        var returnValue: Output
        self.alreadySearchedPath = Array<Output>()
        if(self.numberOfColumns == 1)
        {
            returnValue = self.oneColumnMatrixEvalution()
        }
        else{
            /*
             Path starting first row and first column with minimum cost less than maximum cost value for path
             */
            returnValue = self.costOfPathWithStartingPath(outPutUntilNow: Output(completeMatrixPath: true, costOfPath: self.costArray[0][0], pathArray: [0]),column: 0)
            for i in 1..<self.numberOfRows
            {
                /*
                 Path starting next row and first column with minimum cost less than maximum cost value for path
                 */
                let tempValue:Output = self.costOfPathWithStartingPath(outPutUntilNow: Output(completeMatrixPath: true, costOfPath: self.costArray[i][0], pathArray: [i]),column: 0)
                if(tempValue.costOfPath < returnValue.costOfPath)
                {
                    returnValue = tempValue
                }
                
            }
        }
        /*
         Check path cost exceeds maximum value
         */
        var j:Int = 0
        var costOfPath:Int = 0
        var path:[Int] = Array()
        for i in returnValue.pathArray
        {
           let tempCost = costOfPath + self.costArray[i][j]
            j = j + 1
            if(tempCost > self.maximumCostValueForPath)
            {
                returnValue = Output(completeMatrixPath: false, costOfPath: costOfPath, pathArray:path)
                break
            }
            costOfPath = tempCost
            path.append(i)
        }
        /*
         As the return value contains array of Rows in the cost array whose index starts from zero we need to increase it by 1
         */
        var pathArray:[Int] = returnValue.pathArray
        for i in 0..<pathArray.count
        {
            pathArray[i] = pathArray[i]+1
        }
        returnValue.pathArray = pathArray
        return returnValue
    }
    
    final func nextUpperDigonalPath(latestPathValue:Int) -> Int
    {
        return latestPathValue == 0 ? self.numberOfRows - 1 : latestPathValue - 1
    }
    
    final func nextLowerDigonalPath(latestPathValue:Int) -> Int
    {
        return latestPathValue == self.numberOfRows - 1 ? 0 : latestPathValue + 1
    }
    
    final func nextSameLinePath(latestPathValue:Int) -> Int
    {
        return latestPathValue
    }
    
    final func nextUpperDigonalCost(latestPathValue:Int,column:Int) -> Int
    {
        return self.costArray[self.nextUpperDigonalPath(latestPathValue: latestPathValue)][column+1]
    }
    
    final func nextLowerDigonalCost(latestPathValue:Int,column:Int) ->Int
    {
        return self.costArray[self.nextLowerDigonalPath(latestPathValue: latestPathValue)][column+1]
    }
    
    final func nextSameLineCost(latestPathValue:Int,column:Int) -> Int
    {
        return self.costArray[latestPathValue][column+1]
    }
    
    
    
    /*
     To find all posible three paths from the current path
     */
    final func findAllThreePosiblePathFromCurrentPath(outputUntilNow:Output,column:Int) -> (upperDigonal:Output,sameLine:Output,lowerDigonal:Output)
    {
        var upperFound:Output?=nil
        var middelFound:Output?=nil
        var lowerFound:Output?=nil
        /*
         Check whether the cost of path is already computed and cached
         */
        for index in alreadySearchedPath!
        {
            if(index.pathArray.count > 0 && index.pathArray.first! == self.nextUpperDigonalPath(latestPathValue: outputUntilNow.latestPath()) && index.pathArray.count == self.numberOfColumns - column - 1)
            {
                upperFound = index
            }
            else if(index.pathArray.count>0 && index.pathArray.first! == self.nextSameLinePath(latestPathValue: outputUntilNow.latestPath()) && index.pathArray.count == self.numberOfColumns - column - 1)
            {
                middelFound = index
            }
            else if(index.pathArray.count>0 && index.pathArray.first! == self.nextLowerDigonalPath(latestPathValue: outputUntilNow.latestPath()) && index.pathArray.count == self.numberOfColumns - column - 1 )
            {
                lowerFound = index
            }
        }
        
        let latestPath = outputUntilNow.latestPath()
        let costOfUpperDignolPath = self.nextUpperDigonalCost(latestPathValue: latestPath, column: column)
        let costOfLowerDignolPath = self.nextLowerDigonalCost(latestPathValue: latestPath, column: column)
        let costOfSameLinePath = self.nextSameLineCost(latestPathValue: latestPath, column: column)
        var upperDigonalPath = outputUntilNow.pathArray
        var sameLinePath = outputUntilNow.pathArray
        var lowerDigonalPath = outputUntilNow.pathArray
        var upperDignolReturnValue:Output
        var sameLineReturnValue:Output
        var lowerDigonalReturnValue:Output
        upperDigonalPath.append(self.nextUpperDigonalPath(latestPathValue: latestPath))
        sameLinePath.append(self.nextSameLinePath(latestPathValue: latestPath))
        lowerDigonalPath.append(self.nextLowerDigonalPath(latestPathValue: latestPath))
        
        if(upperFound == nil)
        {
            
                /*
                 If cost of path is not already computed then try to retrive it.
                 */
            
            upperDignolReturnValue = self.costOfPathWithStartingPath(outPutUntilNow:Output(completeMatrixPath: true, costOfPath: outputUntilNow.costOfPath+costOfUpperDignolPath, pathArray: upperDigonalPath),column: column+1)
        
        }
        else{
            /*
             If the cost of path is already computed then Just need to add the path. But before adding it we need to check whether it exceeds the maximum cost.
             */
            
                upperDignolReturnValue = Output(completeMatrixPath: true, costOfPath: outputUntilNow.costOfPath + (upperFound?.costOfPath)!, pathArray: outputUntilNow.pathArray + (upperFound?.pathArray)!)
            
        }
        
        if(middelFound==nil)
        {
            if(upperDigonalPath == sameLinePath)
            {
                /*
                 If both the path are same then no need to find new value We can stop repeatative recursion by this.
                 */
                sameLineReturnValue = upperDignolReturnValue
            }
            else{
               
                sameLineReturnValue = self.costOfPathWithStartingPath(outPutUntilNow:Output(completeMatrixPath: true, costOfPath: outputUntilNow.costOfPath+costOfSameLinePath, pathArray: sameLinePath),column: column+1)
            }
        }
        else
        {
            
            sameLineReturnValue = Output(completeMatrixPath: true, costOfPath: outputUntilNow.costOfPath + (middelFound?.costOfPath)!, pathArray: outputUntilNow.pathArray + (middelFound?.pathArray)!)
            
        }
        if(lowerFound == nil)
        {
            
                if(upperDigonalPath == sameLinePath && sameLinePath == lowerDigonalPath)
                {
                    /*
                     If all three paths are same then no need to find new value  We can stop repeatative recursion by this.
                     */
                    lowerDigonalReturnValue = upperDignolReturnValue
                }
                    /*
                     If two path matches each other
                     */
                else if(sameLinePath == lowerDigonalPath)
                {
                    
                    lowerDigonalReturnValue = sameLineReturnValue
                }
                else if(lowerDigonalPath == upperDigonalPath)
                {
                    lowerDigonalReturnValue = upperDignolReturnValue
                }
                else
                {
                    lowerDigonalReturnValue = self.costOfPathWithStartingPath(outPutUntilNow:Output(completeMatrixPath: true, costOfPath: outputUntilNow.costOfPath+costOfLowerDignolPath, pathArray: lowerDigonalPath),column: column+1)
                }
            
        }
        else
        {
            
            lowerDigonalReturnValue = Output(completeMatrixPath: true, costOfPath: outputUntilNow.costOfPath + (lowerFound?.costOfPath)!, pathArray: outputUntilNow.pathArray + (lowerFound?.pathArray)!)
            
        }
        
        
        return (upperDignolReturnValue,sameLineReturnValue,lowerDigonalReturnValue)
    }
    /*
     This method identifies the minumum cost path from starting row and using recursion.
     With  break point as below
     -- When column value reaches the numberOfColumns in matrix
     */
    final func costOfPathWithStartingPath(outPutUntilNow:Output,column:Int) -> Output
    {
        var returnValue: Output
        
        
        
        if(column+1 >= self.numberOfColumns)
        {
            /*
             Second breaking point of recursion. Because there is no further column left to traverse.
             */
            returnValue = Output(completeMatrixPath: true, costOfPath: outPutUntilNow.costOfPath, pathArray: outPutUntilNow.pathArray)
        }
        else{
            
            
            
            let allThreePaths:(upperDigonal:Output,sameLine:Output,lowerDigonal:Output) = self.findAllThreePosiblePathFromCurrentPath(outputUntilNow: outPutUntilNow, column: column)
            
            returnValue = Output.chooseLeastCostPathWithMiximumTraversedPoint(upperDigonal: allThreePaths.upperDigonal, sameLine: allThreePaths.sameLine, lowerDigonal: allThreePaths.lowerDigonal)
            /*
             caching the minimum cost of path already computed so that if the program encounters the same point it can use this already computed result.
             */
            alreadySearchedPath?.append( returnValue.reducePreviousPath(column: column, fromMatrix: self.costArray))
        }
        return returnValue
    }
    
}

