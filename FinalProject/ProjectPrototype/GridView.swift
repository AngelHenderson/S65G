//
//  GridView.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class GridView: UIView {

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
        }
    }
    
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.darkGrayColor()
    @IBInspectable var bornColor: UIColor = UIColor.blueColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    @IBInspectable var gridColor: UIColor = UIColor.grayColor()
    @IBInspectable var gridWidth: CGFloat = 2
    
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


    class GridChangedNotification {
        let myGridProtocol : GridProtocol
        init(s : GridProtocol) {
            myGridProtocol = s
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
            let currentCell: CellState  = StandardEngine.sharedInstance.grid[colIndex,rowIndex]
            
            StandardEngine.sharedInstance.grid[colIndex,rowIndex] = (rowIndex < StandardEngine.sharedInstance.cols && rowIndex >= 0 && colIndex < StandardEngine.sharedInstance.rows && colIndex >= 0 ? currentCell.toggle(currentCell) : StandardEngine.sharedInstance.grid[colIndex,rowIndex])
            
            let gridRect = CGRect(x: CGFloat(rowIndex) * gridSpaceBetweenCols + gridWidth / 2, y:  CGFloat(colIndex) * gridSpaceBetweenRows + gridWidth / 2, width: gridSpaceBetweenCols - gridWidth, height: gridSpaceBetweenRows - gridWidth)
            
            let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo:["grid":GridChangedNotification(s: StandardEngine.sharedInstance.grid)])

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
