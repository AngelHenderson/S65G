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
    
    private var cells : [CellState] =  Array<CellState>(count: 100, repeatedValue: .Empty)


    var rows: UInt = 0
    var cols: UInt = 0
    
    required init(rows: UInt,cols: UInt) {
        self.rows  = rows
        self.cols = cols
        
        cells = Array<CellState>(count: Int(self.rows), repeatedValue: .Empty)
        //cells = Array (count: Int(self.rows), repeatedValue: Array(count: Int(self.cols), repeatedValue: .Empty))

    }
    
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