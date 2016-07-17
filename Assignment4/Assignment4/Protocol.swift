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


//Previously Array
protocol GridProtocol {
    var rows: UInt { get }
    var cols: UInt { get }
    init(rows: Int, cols: Int)
    func neighbors(tuple:(row: Int, column: Int), maxWidth: Int, maxHeight: Int) -> [(row: Int, column: Int)]
    subscript(row: UInt, col: UInt) -> CellState? { get set }
    var cells : [[CellState]] { get set }
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
    
    private static var _sharedInstance = Grid(rows: 10, cols: 10)
    static var sharedInstance: Grid {
        get {
            return _sharedInstance
        }
    }
    
    var cells : [[CellState]] = Array (count: 10, repeatedValue: Array(count: 10, repeatedValue: .Empty))
    
    required init(rows: Int,cols: Int) {
        self.rows  = UInt(rows)
        self.cols = UInt(cols)
        //cells = Array<CellState>(count: Int(self.rows), repeatedValue: .Empty)
        cells = Array (count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
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
    
    
    private static var _sharedInstance = StandardEngine(rows: 10, cols: 10)
    static var sharedInstance: StandardEngine {
        get {
            return _sharedInstance
        }
    }
    
    var delegate: EngineDelegate?
    var grid: GridProtocol  = Grid.sharedInstance
        
    var rows: UInt = 10 {
        didSet {
        }
    }
    var cols: UInt = 10 {
        didSet {
        }
    }
    
     required init(rows: UInt,cols: UInt) {
        self.rows  = rows
        self.cols = cols
    }
    
    private var timer:NSTimer?
    
    var refreshInterval: NSTimeInterval = 0 {
        didSet {
            if refreshInterval != 0 {
                if let timer = timer { timer.invalidate() }
                let sel = #selector(StandardEngine.timerDidFire(_:))
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
    
    var refreshRate: Double = 0.0 {
        didSet {
            
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
    

    
    func step() -> GridProtocol
    {
        var height : Int = 0
        var width : Int = 0
        
        height = grid.cells.count
        
        for item in grid.cells {
            width = item.count
            break
        }
        
        //Creating a 2-dimensional array of Bool's
        var beforeTwoDBoolArray = Array<Array<CellState>>()
        beforeTwoDBoolArray = grid.cells
        
        
        //For Loop to go through every Cell in the Array
        for w in 0..<width {
            for h in 0..<height {
                
                //Sums up Neighbors Living Cells
                var neighborAliveCount = 0
                
                //Creation of Array of Tuples, A Tuple for each Cell is created
                var tupleArray: [(row:Int,column:Int)] = []
                
                //Neighbor Function checks the neighbor cells of a specific cell
                tupleArray = grid.neighbors((row: w, column: h), maxWidth: width-1, maxHeight: height-1)

                //Loops through the returned Array to determine neighbors living cell count for the specific cell
                for tuple in tupleArray {
                    if (beforeTwoDBoolArray[tuple.row][tuple.column] == .Living || beforeTwoDBoolArray[tuple.row][tuple.column] == .Born) {
                        neighborAliveCount += 1
                    }
                }
                
                let currentCell: CellState  = beforeTwoDBoolArray[w][h]
                
                //Determines if Current Cell is Living or Dead Cell
                if (currentCell == .Living || currentCell == .Born) {
                    
                    if neighborAliveCount == 2 || neighborAliveCount == 3 {
                        grid.cells[w][h] = .Living
                    } else {
                        grid.cells[w][h] = .Died
                    }
                }
                else if (currentCell == .Died || (currentCell == .Empty)) {
                    if neighborAliveCount == 3 {
                        grid.cells[w][h] = .Born
                    }
                    else {
                        grid.cells[w][h] = .Empty
                    }
                }
            }
        }

        //Returns the Array
        return grid
    }

}
