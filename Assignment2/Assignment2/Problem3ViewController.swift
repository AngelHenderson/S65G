//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by Angel Henderson on 6/29/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class Problem3ViewController: UIViewController {

    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Sets the title for the navigation bar
        self.title = "Problem 3"
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
        
        //Post the Number of Living Cells Count to TextView
        textView.text = "Before Alive Cell Count is \(aliveCount)"

        
        // Problem 3
        //Extract the cell logic in Problem 2 to a top level function called step() which accepts a 2D array of bools as input and returns a 2D array of bools as output. Place that function in a separate swift file called Engine.swift. Repeat Problem 2 only invoking step() instead of embedding the logic in the IBAction
        
        
        //Creating a 2-dimensional array of Bool's for After Array
        var afterTwoDBoolArray = Array<Array<Bool>>()
        
        //Sets Initial After Living Cells Count to Zero
        var afterAliveCount = 0
        
        
        //Steps Function which accepts the Before 2D Array of bools and returns the After 2D array of bools
        afterTwoDBoolArray = step(beforeTwoDBoolArray)
        
        
        //Counts the total number of True(Living Cells) values in the After Array
        for arrayOfBool in afterTwoDBoolArray {
            for boolValue in arrayOfBool {
                afterAliveCount += ((boolValue == true) ? 1 : 0)
            }
        }
        
        //Post the Number of Before and After Living Cells Count to TextView
        textView.text = "Before Alive Cell Count is \(aliveCount) and the After Alive Cell Count is \(afterAliveCount)"
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
