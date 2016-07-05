//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Angel Henderson on 6/29/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var runButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Sets the title for the navigation bar
        self.title = "Problem 2"
    }
    
    
    @IBAction func runButtonAction(sender: AnyObject) {
        
        //Testing to determine that Button Action is working
        textView.text = "The button seems to be working as intended"
        
        
        //Problem 2: Part 1 and 2
        //create a 2-dimensional array of Bool's called before to hold the alive dead state and initialize that to some random value with arc4random upon entry to the IBAction. Initially, 1/3rd of the cells should be alive
        
        
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
        
        
        //Problem 2: Part 3
        //Count and print the number of living cells in before to the UITextView

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

        
        //Problem 2: Part 4
        //loop over the before 2D array and count the living neighbors of each cell using a switch statement, observing the wrapping rules. Place the result of applying the rules above into the corresponding cell in the "after" 2D array.
        
        
        //Creating a 2-dimensional array of Bool's for After Array
        var afterTwoDBoolArray = Array<Array<Bool>>()
        afterTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))

        //Sets Initial After Living Cells Count to Zero
        var afterAliveCount = 0

        //For Loop to go through every Cell in the Array
        for w in 0..<width {
            for h in 0..<height {
                
                //This variable is set to determining alive count total for neightbors
                var neighborAliveCount = 0
                
                let coordinatePoint = (w, h)
                
                switch coordinatePoint
                {
                    //Wrapping rules: Four Corners (Determines neightbors living cell count for cells in the corners)
                    case let (x, y) where x == 0 && y == 0:
                        
                        //Sums up Neighbors Living Cells
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[1][1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                        
                    case let (x, y) where x == 0 && y == 9:
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[1][8] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                        
                    case let (x, y) where x == 9 && y == 0:
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[8][1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                        
                    case let (x, y) where x == 9 && y == 9:
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[8][8] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                        
                    //Wrapping rules: Horizontal Edges
                    case let (x, y) where x > 0 && x < 9 && y == 0:
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                        
                    case let (x, y) where x > 0 && x < 9 && y == 9:
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][0] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][0] == true) ? 1 : 0)
                        
                    //Wrapping rules: Vertical Edges
                    case let (x, y) where y > 0 && y < 9 && x == 0:
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[9][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[9][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                        
                    case let (x, y) where y > 0 && y < 9 && x == 9:
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[0][y+1] == true) ? 1 : 0)
                        
                    //All Other Cells
                    case let (x, y):
                        neighborAliveCount = 0
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        neighborAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                    }
                
                //Determines if Current Cell is Living or Dead Cell
                if (beforeTwoDBoolArray[w][h] == true) {
                    
                    //Any live cell with two or three live neighbors lives on to the next generation or dies do to overcrowding or under-population
                    afterTwoDBoolArray[w][h] = ((neighborAliveCount == 2 || neighborAliveCount == 3) ? true : false)
                    
                    //Added the living cell to total living cells count if it is still living
                    afterAliveCount += ((neighborAliveCount == 2 || neighborAliveCount == 3) ? 1 : 0)
                }
                else {
                    //Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction or else it is still dead
                    afterTwoDBoolArray[w][h] = ((neighborAliveCount == 3) ? true : false)
                    
                    //Added the dead cell to total living cells count if it is now living
                    afterAliveCount += ((neighborAliveCount == 3) ? 1 : 0)
                }
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
