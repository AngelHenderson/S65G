//
//  TwoDimensional.swift
//  Assignment2
//
//  Created by Angel Henderson on 6/29/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import Foundation
import UIKit

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

typealias LifeArray = Array<Array<Int>>
typealias CellIndex = (height: Int, width: Int)

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
        
//        for arrayOfInt in tmpArray {
//            for intValue in arrayOfInt {
//                
//            }
//        }
        
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


