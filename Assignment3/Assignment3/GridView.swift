//
//  GridView.swift
//  Assignment3
//
//  Created by Angel Henderson on 7/9/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

    //@IBInspectable var rows:Int = 20
    //@IBInspectable var cols:Int = 20
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var bornColor: UIColor = UIColor.blueColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    @IBInspectable var gridColor: UIColor = UIColor.grayColor()
    @IBInspectable var gridWidth: CGFloat = 10

    var grid = [[CellState]]()

    @IBInspectable var rows : Int = 20{
        //First this
        willSet {
            //print("Old value is \(rows), new value is \(newValue)")
        }
        
        //Finaly this
        didSet {
            grid = Array (count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
            //print("Old value is \(oldValue), new value is \(grid)")
        }
    }
    
    @IBInspectable var cols : Int = 20 {
        willSet {
            //print("Old value is \(rows), new value is \(newValue)")
        }        
        didSet {
            grid = Array (count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
            //print("Old value is \(oldValue), new value is \(grid)")
        }
    }
    
    
    
    override func drawRect(rect: CGRect) {
        
        var startPoint: CGPoint = CGPoint(x: 0, y: 0)
        var endPoint: CGPoint = CGPoint(x: 0, y: 0)
        
        let gridLinePath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        gridLinePath.lineWidth = gridWidth
        
        //Draws Grid Lines for Rows
        for i in 0..<rows {
            let gridSpace: CGFloat = CGFloat(self.frame.size.height) / CGFloat(rows)
            startPoint.x = gridSpace * CGFloat(i)
            startPoint.y = 0.0
            
            endPoint.x = startPoint.x;
            endPoint.y = self.frame.size.height;
            
            //move the initial point of the path
            //to the start of the horizontal stroke
            gridLinePath.moveToPoint(CGPoint(x: startPoint.x, y: startPoint.y))
            
            //add a point to the path at the end of the stroke
            gridLinePath.addLineToPoint(CGPoint(x: endPoint.x, y: endPoint.y))
            
            //set the stroke color
            gridColor.setStroke()
            
            //draw the stroke
            gridLinePath.stroke()
            
            //print("Rows: The x point is \(startPoint.x) and the y point \(endPoint.x)")
        }
        
        //Draws Grid Lines for Columns
        for j in 0..<cols {
            let gridSpace: CGFloat = CGFloat(self.frame.size.width) / CGFloat(cols)
            
            startPoint.x = 0.0;
            startPoint.y = gridSpace * CGFloat(j)

            endPoint.x = self.frame.size.width;
            endPoint.y = startPoint.y;
            
            //move the initial point of the path
            //to the start of the horizontal stroke
            gridLinePath.moveToPoint(CGPoint(x: startPoint.x, y: startPoint.y))
            
            //add a point to the path at the end of the stroke
            gridLinePath.addLineToPoint(CGPoint(x: endPoint.x, y: endPoint.y))
            
            //set the stroke color
            gridColor.setStroke()
            
            //draw the stroke
            gridLinePath.stroke()
            
            //print("Columns: The x point is \(startPoint.y) and the y point \(endPoint.y)")
        }
    }
    
    /*for(int i = 1; i <= self.numberOfColumns; i++)
    {
        CGPoint startPoint;
        CGPoint endPoint;

        startPoint.x = columnWidth * i;
        startPoint.y = 0.0f;

        endPoint.x = startPoint.x;
        endPoint.y = self.frame.size.height;

        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
    }
    
    // ---------------------------
    // Drawing row lines
    // ---------------------------
    
    // calclulate row height
    CGFloat rowHeight = self.frame.size.height / (self.numberOfRows + 1.0);
    
    for(int j = 1; j <= self.numberOfRows; j++)
    {
        CGPoint startPoint;
        CGPoint endPoint;
        
        startPoint.x = 0.0f;
        startPoint.y = rowHeight * j;
        
        endPoint.x = self.frame.size.width;
        endPoint.y = startPoint.y;
        
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
    }*/
    
    
}
