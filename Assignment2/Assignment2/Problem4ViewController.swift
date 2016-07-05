//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Angel Henderson on 6/29/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {

    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Sets the title for the navigation bar 
        self.title = "Problem 4"

        // Do any additional setup after loading the view.
    }

    @IBAction func runButtonAction(sender: AnyObject) {
        
        //Creating a 2-dimensional array of Bool's
        var beforeTwoDBoolArray = Array<Array<Bool>>()
        
        let height : Int
        let width : Int
        
        height = 10
        width = 10
        
        beforeTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))
        
        //Initialize Array with arc4random
        for w in 0..<width {
            for h in 0..<height {
                if arc4random_uniform(3) == 1 {
                    beforeTwoDBoolArray[w][h] = true
                }
            }
        }
        
        
        //Sets Initial Living Cells Count to Zero
        var aliveCount = 0

        
        //Counts the total number of True(Living Cells) values in the Before Array
        for arrayOfBool in beforeTwoDBoolArray {
            for boolValue in arrayOfBool {
                aliveCount += ((boolValue == true) ? 1 : 0)
            }
        }
        
        
        //Problem 4 (15 points)
        //Extract the logic for computing neighbors of a cell according to the wrapping rules into a top-level function called
        //neighbors() which accepts a tuple of row-column coordinates and returns an array of row-column tuples of coordinates
        //where each member of the returned array is a different neighbor of the input coordinate. Repeat Problem 3 only
        //invoking creating a function called step2() which invokes neighbors() instead of directly embedding that
        //functionality.
        
        //Creating a 2-dimensional array of Bool's for After Array
        var afterTwoDBoolArray = Array<Array<Bool>>()
        
        //Sets Initial After Living Cells Count to Zero
        var afterAliveCount = 0
        
        
        //Step2 Function which accepts the Before 2D Array of bools and returns the After 2D array of bools
        afterTwoDBoolArray = step2(beforeTwoDBoolArray)
        
        
        //Counts the total number of True(Living Cells) values in the After Array
        for arrayOfBool in afterTwoDBoolArray {
            for boolValue in arrayOfBool {
                afterAliveCount += ((boolValue == true) ? 1 : 0)
            }
        }
        
        //Post the Number of Before and After Living Cells Count to TextView
        textView.text = "Before Alive Cell Count is \(aliveCount) and the After Alive Cell Count is \(afterAliveCount) "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
