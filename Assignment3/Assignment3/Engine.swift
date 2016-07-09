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
    

    func allValues() -> [String] {
        return [Living.rawValue, Empty.rawValue, Born.rawValue, Died.rawValue]
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