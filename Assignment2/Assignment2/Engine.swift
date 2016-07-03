//
//  TwoDimensional.swift
//  Assignment2
//
//  Created by Angel Henderson on 6/29/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import Foundation
import UIKit

func step(array: Array<Array<Bool>>) -> Array<Array<Bool>>
{
    let height : Int
    let width : Int
    
    height = 10
    width = 10
    
    var aliveCount = 0
    
    for arrayOfBool in array {
        for boolValue in arrayOfBool {
            aliveCount += ((boolValue == true) ? 1 : 0)
        }
    }
    
    
    var beforeTwoDBoolArray = Array<Array<Bool>>()
    beforeTwoDBoolArray = array

    var afterTwoDBoolArray = Array<Array<Bool>>()
    afterTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))
    
    var afterAliveCount = 0
    
    for w in 0..<width {
        for h in 0..<height {
            
            var secondAliveCount = 0
            
            
            let coordinatePoint = (w, h)
            
            switch coordinatePoint
            {
            //Wrapping rules: Four Corners
            case let (x, y) where x == 0 && y == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                
            case let (x, y) where x == 0 && y == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                
            case let (x, y) where x == 9 && y == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                
            case let (x, y) where x == 9 && y == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                
            //Wrapping rules: Horizontal Edges
            case let (x, y) where x > 0 && x < 9 && y == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                
            case let (x, y) where x > 0 && x < 9 && y == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][0] == true) ? 1 : 0)
                
            //Wrapping rules: Vertical Edges
            case let (x, y) where y > 0 && y < 9 && x == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[9][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                
            case let (x, y) where y > 0 && y < 9 && x == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][y+1] == true) ? 1 : 0)
                
            //All Other Cells
            case let (x, y):
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
            }
            
            if (beforeTwoDBoolArray[w][h] == true) {
                afterTwoDBoolArray[w][h] = ((secondAliveCount == 2 || secondAliveCount == 3) ? true : false)
                afterAliveCount += ((secondAliveCount == 2 || secondAliveCount == 3) ? 1 : 0)
            }
            else {
                afterTwoDBoolArray[w][h] = ((secondAliveCount == 3) ? true : false)
                afterAliveCount += ((secondAliveCount == 3) ? 1 : 0)
            }
        }
    }
    
    return afterTwoDBoolArray
}


func step2(array: Array<Array<Bool>>) -> Array<Array<Bool>>
{
    let height : Int
    let width : Int
    
    height = 10
    width = 10
    
    var aliveCount = 0
    
    for arrayOfBool in array {
        for boolValue in arrayOfBool {
            aliveCount += ((boolValue == true) ? 1 : 0)
        }
    }

    var beforeTwoDBoolArray = Array<Array<Bool>>()
    beforeTwoDBoolArray = array
    
    var afterTwoDBoolArray = Array<Array<Bool>>()
    afterTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))
    
    var afterAliveCount = 0
    
    for w in 0..<width {
        for h in 0..<height {
            
            var secondAliveCount = 0
            
            let coordinatePoint = (w, h)
            
            switch coordinatePoint
            {
            //Wrapping rules: Four Corners
            case let (x, y) where x == 0 && y == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                
            case let (x, y) where x == 0 && y == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                
            case let (x, y) where x == 9 && y == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                
            case let (x, y) where x == 9 && y == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][8] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                
            //Wrapping rules: Horizontal Edges
            case let (x, y) where x > 0 && x < 9 && y == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                
            case let (x, y) where x > 0 && x < 9 && y == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][0] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][0] == true) ? 1 : 0)
                
            //Wrapping rules: Vertical Edges
            case let (x, y) where y > 0 && y < 9 && x == 0:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[9][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[9][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                
            case let (x, y) where y > 0 && y < 9 && x == 9:
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[0][y+1] == true) ? 1 : 0)
                
            //All Other Cells
            case let (x, y):
                secondAliveCount = 0
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
            }
            
            if (beforeTwoDBoolArray[w][h] == true) {
                afterTwoDBoolArray[w][h] = ((secondAliveCount == 2 || secondAliveCount == 3) ? true : false)
                afterAliveCount += ((secondAliveCount == 2 || secondAliveCount == 3) ? 1 : 0)
            }
            else {
                afterTwoDBoolArray[w][h] = ((secondAliveCount == 3) ? true : false)
                afterAliveCount += ((secondAliveCount == 3) ? 1 : 0)
            }
        }
    }
    
    return afterTwoDBoolArray
}


func neighbors(tuple:(row: Int, column: Int)) -> [(row: Int, column: Int)]
{
    
    return [(row: 0, column: 0)]
}



/*
 typealias LifeArray = Array<Array<Bool>>
 typealias CellIndex = (height: Int, width: Int)
 
 enum NeighborStatus {
 
 case alive
 case dead
 case starved
 case overpopulated
 case reproduced
 
 //Dynamic Variable
 var isAlive : Bool {
 
 switch (self) {
 case .alive:
 fallthrough
 case .reproduced:
 return true
 
 case .overpopulated,
 .starved,
 .dead:
 return false
 }
 }
 }

 class TwoDimensional {
 
 enum Colors {
 case Red, Orange, Yellow, Green, Blue, Indigo, Violet
 }
 
 let height : Int
 let width : Int
 
 //let twoDimArrayInt: Array<Array<Int>>
 let twoDimArrayInt: LifeArray
 
 init (height: Int, width: Int) {
 self.height = height
 self.width = width
 
 var tmpArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: 0))
 
 for h in 0..<height {
 for w in 0..<width {
 tmpArray[h][w] = Int(arc4random_uniform(3))
 }
 }
 
 self.twoDimArrayInt = tmpArray
 }
 
 func printMyArray () {
 for arrayOfInt in twoDimArrayInt {
 var stringLog = ""
 
 for intValue in arrayOfInt {
 //stringLog += "\(intValue)"
 stringLog += "\((intValue == 1) ? "X" : "O")"
 
 }
 print (stringLog)
 }
 }
 
 func countOfAliveCell () {
 var aliveCount = 0
 
 for arrayOfInt in twoDimArrayInt {
 for intValue in arrayOfInt {
 //stringLog += "\(intValue)"
 //                if intValue == 1 {
 //                    aliveCount += 1
 //                }
 aliveCount += ((intValue == 1) ? 1 : 0)
 }
 }
 print ("Alive Count is \(aliveCount)")
 
 }
 
 /*
 X X X O O
 X T X O O
 X X X O O
 O O O O O
 O O O O O
 
 //Finding List of Neighbors as a Tuple
 //Don't Add yourself (Common Mistakes)
 */
 
 
 
 /**
 - parameter value: prints value
 - returns: the value to be printed
 */
 
 
 internal func somethingElse(value: Int = 0) -> Int {
 print (value)
 return value
 }
 
 func whoAreMyNeighbors (target : CellIndex) -> [CellIndex]? {
 //Validation
 if (target.height < 0 || target.height >= self.height) {
 return nil
 }
 return [CellIndex(height:0, width: 1)]
 }
 }
 */

