//
//  PacmanView.swift
//  FinalProject
//
//  Created by Angel Henderson on 8/2/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class PacmanView: UIView {

    var PacmanColor: UIColor = UIColor.yellowColor()
    var pacManArray: [(Int,Int)] = []
    
    var PacmanPoints:[(Int,Int)] {
        get {
            return pacManArray
        }
        set (newValue) {
            pacManArray = []
            let pointX: Int = newValue[0].0
            let pointY: Int = newValue[0].1
            
            for row in pointX-3...pointX+3 {
                for col in pointY-3...pointY+3 {
                    pacManArray.append(row,col)
                }
            }
            self.setNeedsDisplay()
        }
    }
    
    var points:[(Int,Int)] {
        get {
            //The getter for points should return an array of coordinates which are currently living (born or alive)
            var pointsArray: [(Int,Int)] = []
            for row in 0..<StandardEngine.sharedInstance.rows {
                for col in 0..<StandardEngine.sharedInstance.cols {
                    if StandardEngine.sharedInstance.grid[row,col].isLiving() == true { pointsArray.append(row,col)}
                }
            }
            return pointsArray
        }
        set (newValue) {
            //when points is set, all cells EXCEPT for those in points are set to off
            for row in 0..<StandardEngine.sharedInstance.rows {
                for col in 0..<StandardEngine.sharedInstance.cols {
                    StandardEngine.sharedInstance.grid[row,col] = containsTuple(newValue, tuple: (row,col)) == true ?  .Alive : .Empty
                }
            }
            self.setNeedsDisplay()
        }
    }

    
    var livingColor: UIColor = UIColor(red:0.86, green:0.88, blue:0.88, alpha:1.00)
    var emptyColor: UIColor = UIColor.blackColor()
    var bornColor: UIColor = UIColor.grayColor()
    var diedColor: UIColor = UIColor.blackColor()
    var gridColor: UIColor = UIColor(red:0.14, green:0.18, blue:0.85, alpha:1.00)
    var gridWidth: CGFloat = 1
    
    var previousPositionX: Int = 0
    var previousPositionY: Int = 0
    
    override func awakeFromNib() {
        self.multipleTouchEnabled = true
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //creation of Path
        let gridLinePath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        gridLinePath.lineWidth = gridWidth
        
        //Sets Coordinates and Grid Space
        let gridRowX = bounds.origin.x
        var gridRowY = bounds.origin.y
        let gridSpaceBetweenRows = bounds.height / CGFloat(StandardEngine.sharedInstance.rows)
        
        var gridColX = bounds.origin.x
        let gridColY = bounds.origin.y
        let gridSpaceBetweenCols = bounds.width / CGFloat(StandardEngine.sharedInstance.cols)
        
        //Draws Grid Lines for Rows
        for _ in 0...StandardEngine.sharedInstance.rows {
            gridLinePath.moveToPoint(CGPoint(x: gridRowX, y: gridRowY))
            gridLinePath.addLineToPoint(CGPoint(x:gridRowX + bounds.width, y: gridRowY))
            gridRowY += gridSpaceBetweenRows
        }
        
        //Draws Grid Lines for Columns
        for _ in 0...StandardEngine.sharedInstance.cols {
            gridLinePath.moveToPoint(CGPoint(x: gridColX, y: gridColY))
            gridLinePath.addLineToPoint(CGPoint(x:gridColX, y: gridColY + bounds.height))
            gridColX += gridSpaceBetweenCols
        }
        
        //set the stroke color
        gridColor.setStroke()
        
        //draw the stroke
        gridLinePath.stroke()
        
        //Add Circles
        for row in 0..<StandardEngine.sharedInstance.rows {
            for col in 0..<StandardEngine.sharedInstance.cols {
                
                let innerRingRect = CGRect(x: CGFloat(col) * gridSpaceBetweenCols + (gridWidth / 4) + (gridSpaceBetweenCols * 0.125), y: CGFloat(row) * gridSpaceBetweenRows + (gridWidth / 4) + (gridSpaceBetweenRows * 0.125), width: (gridSpaceBetweenCols - gridWidth) * 0.75, height: (gridSpaceBetweenRows - gridWidth) * 0.75)
                let inner = UIBezierPath(ovalInRect: innerRingRect)
                inner.lineWidth = 1
                
                //Sets Color for each Circle
                switch StandardEngine.sharedInstance.grid[row,col] {
                case .Alive:
                    livingColor.setStroke()
                    livingColor.setFill()
                case .Empty:
                    emptyColor.setStroke()
                    emptyColor.setFill()
                case .Born:
                    bornColor.setStroke()
                    bornColor.setFill()
                case .Died:
                    diedColor.setStroke()
                    diedColor.setFill()
                }
                
                //Drawing Pac-man
                if containsTuple(pacManArray, tuple: (row,col)) == true {
                    let flatArrayForX = pacManArray.flatMap {$0.0}
                    let flatArrayForY = pacManArray.flatMap {$0.1}
                    let minY: Int = pacManArray.flatMap {$0.0}.reduce(flatArrayForX[0]) { $0 > $1 ? $1 : $0 }
                    let maxY: Int = pacManArray.flatMap {$0.0}.reduce(flatArrayForX[0]) { $0 > $1 ? $0 : $1 }
                    let minX: Int = pacManArray.flatMap {$0.1}.reduce(flatArrayForY[0]) { $0 > $1 ? $1 : $0 }
                    let maxX: Int = pacManArray.flatMap {$0.1}.reduce(flatArrayForY[0]) { $0 > $1 ? $0 : $1 }
                    
                    //print("\(minX) and \(maxX) and \(minY) and \(maxY)")
                    let offset: [(Int,Int)] = [
                        (minY,minX),(maxY,minX),(minY,maxX),(maxY,maxX),
                        (minY+3,maxX),(minY+3,maxX-1),(minY+3,maxX-2),
                        (minY+2,maxX),(minY+4,maxX),
                    ]
                    containsTuple(offset, tuple: (row,col)) == true ? UIColor.blackColor().setStroke() : PacmanColor.setStroke()
                    containsTuple(offset, tuple: (row,col)) == true ? UIColor.blackColor().setFill() : PacmanColor.setFill()
                }
                
                inner.stroke()
                inner.fill()
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            currentTouches(touch)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            currentTouches(touch)
        }
    }
    
    func currentTouches(touch: UITouch) {
        // Get the first touch and its location in this view controller's view coordinate system
        let touchLocation = touch.locationInView(self)
        
        let gridSpaceBetweenCols = bounds.width / CGFloat(StandardEngine.sharedInstance.cols)
        let gridSpaceBetweenRows = bounds.height / CGFloat(StandardEngine.sharedInstance.rows)
        
        let rowIndex = Int (CGFloat(touchLocation.x) / gridSpaceBetweenCols)
        let colIndex = Int (CGFloat(touchLocation.y) / gridSpaceBetweenRows)
        
        if previousPositionX != rowIndex || previousPositionY != colIndex {
            
            //Toggles Between Cell States
            StandardEngine.sharedInstance.grid[colIndex,rowIndex] = (rowIndex < StandardEngine.sharedInstance.cols && rowIndex >= 0 && colIndex < StandardEngine.sharedInstance.rows && colIndex >= 0 ? StandardEngine.sharedInstance.grid[colIndex,rowIndex].isLiving() == true ? .Empty : .Alive : StandardEngine.sharedInstance.grid[colIndex,rowIndex])
            
            let gridRect = CGRect(x: CGFloat(rowIndex) * gridSpaceBetweenCols + gridWidth / 2, y:  CGFloat(colIndex) * gridSpaceBetweenRows + gridWidth / 2, width: gridSpaceBetweenCols - gridWidth, height: gridSpaceBetweenRows - gridWidth)
            
            let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo:["grid":GridProtocolWrapper(s: StandardEngine.sharedInstance.grid)])
            NSNotificationCenter.defaultCenter().postNotification(notification)
            
            self.setNeedsDisplayInRect(gridRect)
        }
        
        previousPositionX = rowIndex
        previousPositionY = colIndex
    }
    
    func containsTuple(tupleArray:[(Int,Int)], tuple:(Int,Int)) -> Bool {
        return tupleArray.filter{$0.0 == tuple.0 && $0.1 == tuple.1 }.count > 0
    }

}