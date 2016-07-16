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
    func neighbors(tuple:(row: Int, column: Int), maxWidth: Int, maxHeight: Int) -> [(row: Int, column: Int)]
    subscript(row: UInt, col: UInt) -> CellState? { get set }
}

protocol EngineDelegate {
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol EngineProtocol {
    var delegate: EngineDelegate? { get set }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    var refreshInterval: NSTimeInterval { get set }
    var rows: UInt { get set }
    var cols: UInt { get set }
    
    init(rows: UInt, cols: UInt)
    func step() -> GridProtocol
}


class Grid : GridProtocol {
    
    //private var cells : [CellState] =  Array<CellState>(count: 100, repeatedValue: .Empty)

    var rows: UInt = 10
    var cols: UInt = 10
    
    private var cells : [[CellState]] = Array (count: 10, repeatedValue: Array(count: 10, repeatedValue: .Empty))

    
    required init(rows: UInt,cols: UInt) {
        self.rows  = rows
        self.cols = cols
        
        //cells = Array<CellState>(count: Int(self.rows), repeatedValue: .Empty)
        cells = Array (count: Int(self.rows), repeatedValue: Array(count: Int(self.cols), repeatedValue: .Empty))
    }
    
    subscript(row: UInt, col: UInt) -> CellState? {
        get {
            if cells.count < Int(row*col){
                return nil
            }
            
            return cells[Int(row)][Int(col)]
        }
        set (newValue) {
            if newValue == nil { return }
            if row < 0 || row >= rows || col < 0 || col >= cols {
                return
            }
            //let cellRow = row * cols + col
            //cells[Int(cellRow)] = newValue!
            cells[Int(row)][Int(col)] = newValue!
        }
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
    
}

class StandardEngine  : EngineProtocol {
    
    private var timer:NSTimer?
    
    var refreshInterval: NSTimeInterval = 0 {
        didSet {
            if refreshInterval != 0 {
                if let timer = timer { timer.invalidate() }
                let sel = #selector(Grid.timerDidFire(_:))
                timer = NSTimer.scheduledTimerWithTimeInterval(refreshInterval,
                                                               target: self,
                                                               selector: sel,
                                                               userInfo: ["name": "fred"],
                                                               repeats: true)
            }
            else if let timer = timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    @objc func timerDidFire(timer:NSTimer) {
        self.rows += 1
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "ExampleNotification",
                               object: nil,
                               userInfo: ["name": "fred"])
        center.postNotification(n)
        print ("\(timer.userInfo?["name"] ?? "not fred")")
    }
    
    var delegate: ExampleDelegateProtocol?
    func step() -> [[Bool]] {
        return [[false]]
    }

}
