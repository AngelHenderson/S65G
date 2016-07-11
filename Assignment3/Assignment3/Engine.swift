//
//  Engine.swift
//  Assignment3
//
//  Created by Angel Henderson on 7/8/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import Foundation

enum CellState : String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    func description() -> String {
        switch self {
        case .Living:
            return "Living"
        case .Empty:
            return "Empty"
        case .Born:
            return "Born"
        case .Died:
            return "Died"
        }
    }
    

    func allValues() -> [CellState] {
        return [.Living, .Empty, .Born, .Died]
    }
    
    func toggle(value:CellState) -> CellState {
        switch self {
        case .Empty,.Died:
            return .Living
        case .Living,.Born:
            return .Empty
        }
    }

}


func step(array: Array<Array<CellState>>) -> Array<Array<CellState>>
{
    var height : Int = 0
    var width : Int = 0
    
    height = array.count
    
    for item in array {
        width = item.count
        break
    }
        
    //Creating a 2-dimensional array of Bool's
    var beforeTwoDBoolArray = Array<Array<CellState>>()
    beforeTwoDBoolArray = array
    
    //Creating a 2-dimensional array of Bool's for After Array
    var afterTwoDBoolArray = Array<Array<CellState>>()
    afterTwoDBoolArray = beforeTwoDBoolArray
        
    
    //For Loop to go through every Cell in the Array
    for w in 0..<width {
        for h in 0..<height {
            
            //Sums up Neighbors Living Cells
            var neighborAliveCount = 0
            
            //Creation of Array of Tuples, A Tuple for each Cell is created
            var tupleArray: [(row:Int,column:Int)] = []
            
            //Neighbor Function checks the neighbor cells of a specific cell
            tupleArray = neighbors((row: w, column: h), maxWidth: width-1, maxHeight: height-1)
            
            //Loops through the returned Array to determine neighbors living cell count for the specific cell
            for tuple in tupleArray {
                //print("The Row is \(tuple.row) and The Column is \(tuple.column)")
                neighborAliveCount += ((beforeTwoDBoolArray[tuple.row][tuple.column] == .Living) ? 1 : 0)
            }
            
            let currentCell: CellState  = beforeTwoDBoolArray[w][h]

            //Determines if Current Cell is Living or Dead Cell
            if (currentCell == .Living || currentCell == .Born) {
                
                if neighborAliveCount == 2 || neighborAliveCount == 3 {
                    afterTwoDBoolArray[w][h] = .Living
                } else {
                    afterTwoDBoolArray[w][h] = .Died
                }
            }
            else if (currentCell == .Died) {
                if neighborAliveCount == 3 {
                    afterTwoDBoolArray[w][h] = .Born
                }
                else {
                    afterTwoDBoolArray[w][h] = .Died
                }
            }
            else {
                afterTwoDBoolArray[w][h] = .Empty
                if neighborAliveCount == 2 || neighborAliveCount == 3 {
                    //afterTwoDBoolArray[w][h] = .Born
                }
            }
        }
    }
    
    //Returns the Array
    return afterTwoDBoolArray
}


func neighbors(tuple:(row: Int, column: Int) , maxWidth: Int, maxHeight: Int) -> [(row: Int, column: Int)]
{
    var tupleArray: [(row:Int,column:Int)] = []
    
    let coordinatePoint = (tuple.row, tuple.column)
    
    switch coordinatePoint
    {
    //Wrapping rules: Four Corners (Determines neightbors living cell count for cells in the corners)
    case let (x, y) where x == 0 && y == 0:
        tupleArray += [(row: 0,column: 1)]
        tupleArray += [(row: 0,column: maxHeight)]
        tupleArray += [(row: 1,column: 0)]
        tupleArray += [(row: 1,column: 1)]
        tupleArray += [(row: 1,column: maxHeight)]
        tupleArray += [(row: maxWidth,column: 0)]
        tupleArray += [(row: maxWidth,column: 1)]
        tupleArray += [(row: maxWidth,column: maxHeight)]
        
    case let (x, y) where x == 0 && y == maxHeight:
        tupleArray += [(row: maxWidth,column: 1)]
        tupleArray += [(row: 0,column: maxHeight)]
        tupleArray += [(row: 1,column: 0)]
        tupleArray += [(row: maxWidth,column: 1)]
        tupleArray += [(row: 1,column: maxHeight)]
        tupleArray += [(row: maxWidth,column: 0)]
        tupleArray += [(row: 0,column: 1)]
        tupleArray += [(row: 1,column: maxHeight)]
        
    case let (x, y) where x == maxWidth && y == 0:
        tupleArray += [(row: maxWidth-1,column: 0)]
        tupleArray += [(row: maxWidth-1,column: 1)]
        tupleArray += [(row: maxWidth,column: 1)]
        tupleArray += [(row: maxWidth-1,column: maxHeight)]
        tupleArray += [(row: maxWidth,column: maxHeight)]
        tupleArray += [(row: 0,column: maxHeight)]
        tupleArray += [(row: 0,column: 0)]
        tupleArray += [(row: 0,column: 1)]
        
    case let (x, y) where x == maxWidth && y == maxHeight:
        tupleArray += [(row: 0,column: 0)]
        tupleArray += [(row: 0,column: maxHeight-1)]
        tupleArray += [(row: 0,column: maxHeight)]
        tupleArray += [(row: maxWidth-1,column: 0)]
        tupleArray += [(row: maxWidth,column: 0)]
        tupleArray += [(row: maxWidth-1,column: maxHeight-1)]
        tupleArray += [(row: maxWidth-1,column: maxHeight)]
        tupleArray += [(row: maxWidth,column: maxHeight-1)]
        
    //Wrapping rules: Horizontal Edges
    case let (x, y) where x > 0 && x < maxWidth && y == 0:
        tupleArray += [(row: x-1,column: maxHeight)]
        tupleArray += [(row: x,column: maxHeight)]
        tupleArray += [(row: x+1,column: maxHeight)]
        tupleArray += [(row: x-1,column: y)]
        tupleArray += [(row: x+1,column: y)]
        tupleArray += [(row: x-1,column: y+1)]
        tupleArray += [(row: x,column: y+1)]
        tupleArray += [(row: x+1,column: y+1)]
        
    case let (x, y) where x > 0 && x < maxWidth && y == maxHeight:
        tupleArray += [(row: x-1,column: maxHeight)]
        tupleArray += [(row: x+1,column: maxHeight)]
        tupleArray += [(row: x-1,column: y-1)]
        tupleArray += [(row: x,column: y-1)]
        tupleArray += [(row: x+1,column: y-1)]
        tupleArray += [(row: x-1,column: 0)]
        tupleArray += [(row: x,column: 0)]
        tupleArray += [(row: x+1,column: 0)]
        
    //Wrapping rules: Vertical Edges
    case let (x, y) where y > 0 && y < maxHeight && x == 0:
        tupleArray += [(row: maxWidth,column: y-1)]
        tupleArray += [(row: x,column: y-1)]
        tupleArray += [(row: x+1,column: y-1)]
        tupleArray += [(row: maxWidth,column: y)]
        tupleArray += [(row: x+1,column: y)]
        tupleArray += [(row: maxWidth,column: y+1)]
        tupleArray += [(row: x,column: y+1)]
        tupleArray += [(row: x+1,column: y+1)]
        
    case let (x, y) where y > 0 && y < maxHeight && x == maxWidth:
        tupleArray += [(row: x-1,column: y-1)]
        tupleArray += [(row: x,column: y-1)]
        tupleArray += [(row: 0,column: y-1)]
        tupleArray += [(row: x-1,column: y)]
        tupleArray += [(row: 0,column: y)]
        tupleArray += [(row: x-1,column: y+1)]
        tupleArray += [(row: x,column: y+1)]
        tupleArray += [(row: 0,column: y+1)]
        
    //All Other Cells
    case let (x, y):
        tupleArray += [(row: x-1,column: y-1)]
        tupleArray += [(row: x,column: y-1)]
        tupleArray += [(row: x+1,column: y-1)]
        tupleArray += [(row: x-1,column: y)]
        tupleArray += [(row: x+1,column: y)]
        tupleArray += [(row: x-1,column: y+1)]
        tupleArray += [(row: x,column: y+1)]
        tupleArray += [(row: x+1,column: y+1)]
    }
    
    
    return tupleArray
}
