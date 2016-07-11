//
//  GridView.swift
//  Assignment3
//
//  Created by Angel Henderson on 7/9/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

    private var allPoints = [UITouch : [CGPoint]]()
    private var colors = [UITouch : UIColor]()
    
    var strokeColor: UIColor = UIColor.blackColor()
    
    override func awakeFromNib() {
        self.multipleTouchEnabled = true
    }
    
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
    

    override init(frame: CGRect) {
        grid = Array (count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
        super.init(frame: frame)
    }

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func drawRect(gridRect: CGRect) {
        
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
        
        //Sets Color for each Circle
        for w in 0..<rows {
            for h in 0..<cols {
                
                let gridSpace: CGFloat = CGFloat(self.frame.size.width) / CGFloat(rows)
                let xCoordinate: CGFloat = CGFloat(w)*gridSpace
                let yCoordinate: CGFloat = CGFloat(h)*gridSpace
                //let xCoordinateSpace: CGFloat = CGFloat(w)*gridSpace + (gridSpace*0.5)
                //let yCoordinateSpace: CGFloat = CGFloat(h)*gridSpace + (gridSpace*0.5)
                //let rect = CGRectMake(CGPointZero.x, CGPointZero.y, gridSpace, gridSpace)
                //let rect = CGRectMake(CGPointZero.x, CGPointZero.y, self.bounds.size.height, self.bounds.size.width)
                let rect = CGRectMake(xCoordinate, yCoordinate, gridSpace, gridSpace)
                let w = rect.size.width
                let innerRingRect = CGRectInset(rect, w * 0.15, w * 0.15)
                //innerRingRect.origin.x += xCoordinate
                //innerRingRect.origin.y += yCoordinate
                let inner = UIBezierPath(ovalInRect: innerRingRect)
                inner.lineWidth = 1
                
                let xValue: Int = Int(w)
                let yValue: Int = Int(h)

                let currentCell: CellState  = grid[xValue][yValue]

                switch (currentCell) {
                    case .Living:
                        livingColor.setStroke()
                    case .Empty:
                        emptyColor.setStroke()
                    case .Born:
                        bornColor.setStroke()
                    case .Died:
                        diedColor.setStroke()
                }
                
                //UIColor(white: 0.7, alpha: 1.0).setStroke()
                inner.stroke()
            }
        }
    
        // Drawing code
        let currentContext = UIGraphicsGetCurrentContext()
        for (touch, points) in self.allPoints {
            self.drawPoints(points, color: self.colors[touch]!, context: currentContext!)
        }
    }
    
    
    func drawPoints(points: [CGPoint], color: UIColor, context: CGContextRef) {
        if points.count > 1 {
            let path = CGPathCreateMutable()
            let firstPoint = points[0]
            CGPathMoveToPoint(path, nil, firstPoint.x, firstPoint.y)
            
            for pointIndex in 1..<points.count {
                let point = points[pointIndex]
                CGPathAddLineToPoint(path, nil, point.x, point.y)
            }
            
            CGContextSetStrokeColorWithColor(context, color.CGColor)
            CGContextSetLineWidth(context, 5.0)
            CGContextAddPath(context, path)
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.allPoints[touch ] = [CGPoint]()
            self.colors[touch ] = self.strokeColor
            self.processTouch(touch )
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch )
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch )
        }
    }
    
    func processTouch(touch: UITouch) {
        let point = touch.locationInView(self)
        self.allPoints[touch]?.append(point)
        self.setNeedsDisplay()
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

