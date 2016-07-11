//
//  CellButton.swift
//  Assignment3
//
//  Created by Angel Henderson on 7/10/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class CellButton: UIButton {

    var fillColor = UIColor.whiteColor()

    override func drawRect(rect: CGRect) {
        //let path = UIBezierPath(ovalInRect: rect)
        //fillColor.setFill()
        //path.fill()
        
        let rect = CGRectMake(CGPointZero.x, CGPointZero.y, self.bounds.size.height, self.bounds.size.width)
        let w = rect.size.width
        
        let ringRect = CGRectInset(rect, w * 0.15, w * 0.15)
        let ring = UIBezierPath(ovalInRect: ringRect)
        ring.lineWidth = 1
        UIColor(white: 0.3, alpha: 1.0).setStroke()
        fillColor.setFill()
        ring.stroke()
        ring.fill()
    }


}
