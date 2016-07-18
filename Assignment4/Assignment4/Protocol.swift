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
            return self.rawValue
        case .Empty:
            return self.rawValue
        case .Born:
            return self.rawValue
        case .Died:
            return self.rawValue
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
    var rows: Int { get }
    var cols: Int { get }
    init(rows: Int, cols: Int)
    func neighbors(tuple:(row: Int, column: Int), maxWidth: Int, maxHeight: Int) -> [(row: Int, column: Int)]
    subscript(row: Int, col: Int) -> CellState? { get set }
}

protocol EngineDelegateProtocol {
    func engineDidUpdate(withGrid: Grid)
}

protocol EngineProtocol {
    var delegate: EngineDelegateProtocol? { get set }
    var grid: Grid { get }
    var refreshRate: Double { get set }
    var refreshInterval: NSTimeInterval { get set }
    var rows: Int { get set }
    var cols: Int { get set }
    init(rows: Int, cols: Int)
    func step() -> Grid
}

class Grid : GridProtocol {
    var rows: Int
    var cols: Int
    var cells : [[CellState]]
    
    required init(rows: Int,cols: Int) {
        self.rows  = rows
        self.cols = cols
        cells = [[CellState]] (count:rows, repeatedValue:[CellState](count:cols, repeatedValue:.Empty))
    }
    
    subscript(row: Int, col: Int) -> CellState? {
        get {
            return cells[row][col]
        }
        set (newValue) {
            cells[row][col] = newValue!
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
    
    var delegate: EngineDelegateProtocol?
   
    var grid:Grid {
        didSet {
            let notification = NSNotification(name: "updateGridNotification", object:grid, userInfo: nil)
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
        
    var rows: Int = 10 {
        didSet {
            grid = Grid (rows:rows, cols:cols)
            delegate?.engineDidUpdate(grid)
        }
    }
    var cols: Int = 10 {
        didSet {
            grid = Grid (rows:rows, cols:cols)
            delegate?.engineDidUpdate(grid)
        }
    }
    
     required init(rows: Int,cols: Int) {
        self.rows  = rows
        self.cols = cols
        grid = Grid(rows:rows, cols:cols)
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
        
        let timerNotification = NSNotification(name: "timerNotification", object: nil, userInfo: nil)
        NSNotificationCenter.defaultCenter().postNotification(timerNotification)
    }
    
    func step() -> Grid
    {
        var livingCount = 0
        var bornCount = 0
        var deadCount = 0
        var emptyCount = 0

        let newGrid = Grid(rows:rows,cols:cols)
        
        var height : Int = 0
        var width : Int = 0
        
        height = cols
        width = rows
        
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
                    if (grid[tuple.row,tuple.column] == .Living || grid[tuple.row,tuple.column] == .Born) {
                        neighborAliveCount += 1
                    }
                }
                
                //Determines if Current Cell is Living or Dead Cell
                if (grid[w,h] == .Living || grid[w,h] == .Born) {
                    
                    if neighborAliveCount == 2 || neighborAliveCount == 3 {
                        newGrid[w,h] = .Living
                        livingCount += 1
                    } else {
                        newGrid[w,h] = .Died
                        deadCount += 1

                    }
                }
                else if (grid[w,h] == .Died || (grid[w,h] == .Empty)) {
                    if neighborAliveCount == 3 {
                        newGrid[w,h] = .Born
                        bornCount += 1
                    }
                    else {
                        newGrid[w,h] = .Empty
                        emptyCount += 1
                    }
                }
            }
        }
        
        let notificationDict = [ "livingCount": livingCount, "deadCount": deadCount, "bornCount": bornCount, "emptyCount": emptyCount]
        let notification = NSNotification(name: "cellCountNotification", object:nil, userInfo: notificationDict)
        NSNotificationCenter.defaultCenter().postNotification(notification)

        return newGrid
    }

}
