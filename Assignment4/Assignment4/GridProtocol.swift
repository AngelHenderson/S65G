//
//  GridProtocol.swift
//  Assignment4
//
//  Created by Angel Henderson on 7/15/16.
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

protocol GridProtocol {
    var rows: UInt { get }
    var cols: UInt { get }
    init(rows: UInt, cols: UInt)
    func neighbors(tuple:(row: Int, column: Int)) -> [(row: Int, column: Int)]
    subscript(row: UInt, col: UInt) -> CellState? { get set }
}

protocol EngineDelegate {
    func engineDidUpdate(withGrid: GridProtocol)
}