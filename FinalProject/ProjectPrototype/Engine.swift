import UIKit

typealias Position = (row:Int, col: Int)

enum CellState {
    case Empty
    case Died
    case Born
    case Alive
    
    func isLiving() -> Bool {
        switch self {
        case .Alive, .Born: return true
        case .Died, .Empty: return false
        }
    }
}

typealias Cell = (position: Position, state: CellState)



protocol EngineProtocol {
    var rows: Int { get set }
    var cols: Int { get set }
    var grid: GridProtocol { get }
    weak var delegate: EngineDelegate? { get set }
    var refreshRate:  Double { get set }
    var refreshTimer: NSTimer? { get set }
    var runTimer: Bool {get set}

    func step() -> GridProtocol
}

typealias CellInitializer = (Position) -> CellState

class StandardEngine: EngineProtocol {
    
    static var _sharedInstance: StandardEngine = StandardEngine(20,20)
    static var sharedInstance: StandardEngine { get { return _sharedInstance } }
    
    var grid: GridProtocol

    var rows: Int = 20 {
        didSet {
            // Validate
            if rows < 0 {
                rows = 0
            }
            // Reset
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
            let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo:["grid":GridProtocolWrapper(s: StandardEngine.sharedInstance.grid)])
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    var cols: Int = 20 {
        didSet {
            // Validate
            if cols < 0 {
                cols = 0
            }
            // Reset
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
            let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo:["grid":GridProtocolWrapper(s: StandardEngine.sharedInstance.grid)])
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    weak var delegate: EngineDelegate?
    
    var refreshRate:  Double = 0.0 {
        didSet {
            // clear it
            refreshTimer?.invalidate()
            if refreshRate > 0 && runTimer{
                refreshTimer = NSTimer
                    .scheduledTimerWithTimeInterval(refreshRate,
                                                    target: self,
                                                    selector: #selector(timerTriggered),
                                                    userInfo: nil,
                                                    repeats: true)
            }
        }
    }
    
    var refreshTimer: NSTimer?
    
    func notifyObservers() {
        self.step()
        let notification = NSNotification(name: "updateGridNotification", object: nil, userInfo:["grid":GridProtocolWrapper(s: StandardEngine.sharedInstance.grid)])
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    // MARK: - Private Helper Methods
    @objc func timerTriggered(timer: NSTimer) {
        refreshTimer = timer
        notifyObservers()
    }
    
    var runTimer: Bool {

        didSet {
            //clear it
            refreshTimer?.invalidate()
            
            // Set back up the timer
            // Usually, I prefer helper functions, when there's any
            // repeated code like this...
            if runTimer && refreshRate > 0 {
                refreshTimer = NSTimer
                    .scheduledTimerWithTimeInterval(refreshRate,
                                                    target: self,
                                                    selector: #selector(timerTriggered),
                                                    userInfo: nil,
                                                    repeats: true)
            }
        }
    }
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return grid.cells[i*cols+j].state
        }
        set {
            grid.cells[i*cols+j].state = newValue
        }
    }
    
    init(_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows,cols, cellInitializer: cellInitializer)
        self.runTimer = false
    }
    
    func step() -> GridProtocol {
        var newGrid = Grid(self.rows, self.cols)
        newGrid.cells = grid.cells.map {
            switch grid.livingNeighbors($0.position) {
            case 2 where $0.state.isLiving(),
                 3 where $0.state.isLiving():  return Cell($0.position, .Alive)
            case 3 where !$0.state.isLiving(): return Cell($0.position, .Born)
            case _ where $0.state.isLiving():  return Cell($0.position, .Died)
            default:                           return Cell($0.position, .Empty)
            }
        }
        grid = newGrid
        if let delegate = delegate { delegate.engineDidUpdate(grid) }
        return grid
    }
}

struct Grid: GridProtocol {
    private(set) var rows: Int
    private(set) var cols: Int
    var cells: [Cell]
    
    var living: Int { return cells.reduce(0) { return  $1.state.isLiving() ?  $0 + 1 : $0 } }
    var dead:   Int { return cells.reduce(0) { return !$1.state.isLiving() ?  $0 + 1 : $0 } }
    var alive:  Int { return cells.reduce(0) { return  $1.state == .Alive  ?  $0 + 1 : $0 } }
    var born:   Int { return cells.reduce(0) { return  $1.state == .Born   ?  $0 + 1 : $0 } }
    var died:   Int { return cells.reduce(0) { return  $1.state == .Died   ?  $0 + 1 : $0 } }
    var empty:  Int { return cells.reduce(0) { return  $1.state == .Empty  ?  $0 + 1 : $0 } }
    
    init (_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.cells = (0..<rows*cols).map {
            let pos = Position($0/cols, $0%cols)
            return Cell(pos, cellInitializer(pos))
        }
    }
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return cells[i*cols+j].state
        }
        set {
            cells[i*cols+j].state = newValue
        }
    }
    
    private static let offsets:[Position] = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1)
    ]
    func neighbors(pos: Position) -> [Position] {
        return Grid.offsets.map { Position((pos.row + rows + $0.row) % rows,
            (pos.col + cols + $0.col) % cols) }
    }

    func livingNeighbors(position: Position) -> Int {
        return neighbors(position)
            .reduce(0) {
                self[$1.row,$1.col].isLiving() ? $0 + 1 : $0
        }
    }
}




