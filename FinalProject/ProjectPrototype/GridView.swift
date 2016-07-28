//
//  GridView.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class GridView: UIView {

    var points:[(Int,Int)] = []
    
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var bornColor: UIColor = UIColor.blueColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    @IBInspectable var gridColor: UIColor = UIColor.grayColor()
    @IBInspectable var gridWidth: CGFloat = 10
    var grid: GridProtocol
    
    override func awakeFromNib() {
        self.multipleTouchEnabled = true
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    
        var startPoint: CGPoint = CGPoint(x: 0, y: 0)
        var endPoint: CGPoint = CGPoint(x: 0, y: 0)
        let gridLinePath = UIBezierPath()
        
        //Draws Grid Lines for Rows
        for i in 0..<grid.rows {
            let gridSpace: CGFloat = CGFloat(self.frame.size.height) / CGFloat(grid.rows)
            startPoint.x = gridSpace * CGFloat(i)
            startPoint.y = 0.0
            endPoint.x = startPoint.x;
            endPoint.y = self.frame.size.height;
            
            //move the initial point of the path to the start of the horizontal stroke
            gridLinePath.moveToPoint(CGPoint(x: startPoint.x, y: startPoint.y))
            //add a point to the path at the end of the stroke
            gridLinePath.addLineToPoint(CGPoint(x: endPoint.x, y: endPoint.y))
            //set the stroke color
            gridColor.setStroke()
            //draw the stroke
            gridLinePath.stroke()
        }
        
        //Draws Grid Lines for Columns
        for j in 0..<grid.cols {
            let gridSpaceY: CGFloat = CGFloat(self.frame.size.height) / CGFloat(grid.cols)
            startPoint.x = 0.0;
            startPoint.y = gridSpaceY * CGFloat(j)
            endPoint.x = self.frame.size.width;
            endPoint.y = startPoint.y;
            
            //move the initial point of the path to the start of the horizontal stroke
            gridLinePath.moveToPoint(CGPoint(x: startPoint.x, y: startPoint.y))
            //add a point to the path at the end of the stroke
            gridLinePath.addLineToPoint(CGPoint(x: endPoint.x, y: endPoint.y))
            //set the stroke color
            gridColor.setStroke()
            //draw the stroke
            gridLinePath.stroke()
        }
        
        //set the path's line width to the height of the stroke
        gridLinePath.lineWidth = gridWidth
    }

}
