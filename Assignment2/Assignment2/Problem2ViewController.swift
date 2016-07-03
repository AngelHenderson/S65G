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

        self.title = "Problem 2"
    }
    
    
    @IBAction func runButtonAction(sender: AnyObject) {
        
        textView.text = "The button seems to be working as intended"
        
        
        //Problem 2: Part 1 and 2
        //create a 2-dimensional array of Bool's called before to hold the alive dead state and initialize that to some random value with arc4random upon entry to the IBAction. Initially, 1/3rd of the cells should be alive
        
        var beforeTwoDBoolArray = Array<Array<Bool>>()

        let height : Int
        let width : Int
        
        height = 10
        width = 10
        
        beforeTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))
        
        for w in 0..<width {
            for h in 0..<height {
                if arc4random_uniform(3) == 1 {
                    beforeTwoDBoolArray[w][h] = true
                }
            }
        }
        
        //Problem 2: Part 3
        //count and print the number of living cells in before to the UITextView

        var aliveCount = 0
        
        for arrayOfBool in beforeTwoDBoolArray {
            for boolValue in arrayOfBool {
                aliveCount += ((boolValue == true) ? 1 : 0)
            }
        }
        
        textView.text = "Before Alive Cell Count is \(aliveCount)"

        
        //Problem 2: Part 4
        var afterTwoDBoolArray = Array<Array<Bool>>()
        afterTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))

        var afterAliveCount = 0

        for w in 0..<width {
            for h in 0..<height {
                
                var secondAliveCount = 0
                
                let coordinatePoint = (w, h)
                
                switch coordinatePoint
                {
                    //Wrapping rules: Four Corners
                    case let (x, y) where x == 0 && y == 0:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[1][1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                        
                    case let (x, y) where x == 0 && y == 9:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[1][8] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[1][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[1][0] == true) ? 1 : 0)
                        
                    case let (x, y) where x == 9 && y == 0:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[8][1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][1] == true) ? 1 : 0)
                        
                    case let (x, y) where x == 9 && y == 9:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[0][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][8] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[8][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[8][8] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[8][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][8] == true) ? 1 : 0)
                        
                    //Wrapping rules: Horizontal Edges
                    case let (x, y) where x > 0 && x < 9 && y == 0:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                        
                    case let (x, y) where x > 0 && x < 9 && y == 9:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][9] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][0] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][0] == true) ? 1 : 0)
                        
                    //Wrapping rules: Vertical Edges
                    case let (x, y) where y > 0 && y < 9 && x == 0:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[9][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[9][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                        
                    case let (x, y) where y > 0 && y < 9 && x == 9:
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[0][y+1] == true) ? 1 : 0)
                        
                    //All Other Cells
                    case let (x, y):
                        secondAliveCount = 0
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y-1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x-1][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x][y+1] == true) ? 1 : 0)
                        secondAliveCount += ((beforeTwoDBoolArray[x+1][y+1] == true) ? 1 : 0)
                    }
                
                if (beforeTwoDBoolArray[w][h] == true) {
                    afterTwoDBoolArray[w][h] = ((secondAliveCount == 2 || secondAliveCount == 3) ? true : false)
                    afterAliveCount += ((secondAliveCount == 2 || secondAliveCount == 3) ? 1 : 0)
                }
                else {
                    afterTwoDBoolArray[w][h] = ((secondAliveCount == 3) ? true : false)
                    afterAliveCount += ((secondAliveCount == 3) ? 1 : 0)
                }
            }
        }
        
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
