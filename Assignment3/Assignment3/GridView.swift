//
//  GridView.swift
//  Assignment3
//
//  Created by Angel Henderson on 7/9/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

    @IBInspectable var rows:Int = 20
    @IBInspectable var cols:Int = 20
    @IBInspectable var livingColor = UIColor.greenColor()
    @IBInspectable var emptyColor = UIColor.whiteColor()
    @IBInspectable var bornColor = UIColor.blueColor()
    @IBInspectable var diedColor = UIColor.redColor()
    @IBInspectable var gridColor = UIColor.grayColor()
    @IBInspectable var gridWidth = CGFloat(10)


}
