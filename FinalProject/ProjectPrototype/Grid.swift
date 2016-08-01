//
//  Grid.swift
//  FinalProject
//
//  Created by Angel Henderson on 7/31/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import Foundation

protocol GridProtocol {
    var rows: Int { get }
    var cols: Int { get }
    var cells: [Cell] { get set}
    
    var living: Int { get }
    var dead:   Int { get }
    var alive:  Int { get }
    var born:   Int { get }
    var died:   Int { get }
    var empty:  Int { get }
    
    subscript (i:Int, j:Int) -> CellState { get set }
    
    func neighbors(pos: Position) -> [Position]
    func livingNeighbors(position: Position) -> Int
}


class GridProtocolWrapper {
    let grid : GridProtocol
    init(s : GridProtocol) {
        grid = s
    }
}