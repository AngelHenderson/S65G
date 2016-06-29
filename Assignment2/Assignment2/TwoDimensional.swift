//
//  TwoDimensional.swift
//  Assignment2
//
//  Created by Angel Henderson on 6/29/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import Foundation

enum NeighborStatus {
    
    case alive
    case dead
    case starved
    case overpopulated
    case reproduced
}

class TwoDimensional {
    let height : Int
    let width : Int

    let twoDimArrayInt: Array<Array<Int>>
    init (height: Int, width: Int) {
        self.height = height
        self.width = width
        
        self.twoDimArrayInt = Array (count: height, repeatedValue: Array(count: width, repeatedValue: 0))
    }
}
