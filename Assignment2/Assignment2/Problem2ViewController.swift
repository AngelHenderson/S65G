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
        textView.text = "Hello, this button seems to be working as intended"
        
        
        //Problem 2: Part 1 and 2
        //create a 2-dimensional array of Bool's called before to hold the alive dead state and initialize that to some random value with arc4random upon entry to the IBAction. Initially, 1/3rd of the cells should be alive
        
        var beforeTwoDBoolArray = Array<Array<Bool>>()
        
        let height : Int
        let width : Int
        
        height = 10
        width = 10
        
        beforeTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))
        
        for h in 0..<height {
            for w in 0..<width {
                if arc4random_uniform(3) == 1 {
                    beforeTwoDBoolArray[h][w] = true
                }
            }
        }
        
        print (beforeTwoDBoolArray)
        
        
        //Problem 2: Part 3
        //count and print the number of living cells in before to the UITextView

        var aliveCount = 0
        
        for arrayOfInt in beforeTwoDBoolArray {
            for intValue in arrayOfInt {
                //stringLog += "\(intValue)"
                //                if intValue == 1 {
                //                    aliveCount += 1
                //                }
                aliveCount += ((intValue == true) ? 1 : 0)
            }
        }
        textView.text = "Alive Cell Count is \(aliveCount)"

        
        
        
        
        /*let twoDArray = TwoDimensional(height: 10, width: 10)
        twoDArray.printMyArray()
        twoDArray.somethingElse()
        twoDArray.countOfAliveCell()
        
        let nStatus = NeighborStatus.alive
        let color = TwoDimensional.Colors.Red
        let origin = CellIndex(height: 0, width: 0)
        
        //Checking Neighbors
        var optionalNeighbors = twoDArray.whoAreMyNeighbors((0,0))
        print (optionalNeighbors)
        if let neighbor = optionalNeighbors {
            print(neighbor)
        }
        
        optionalNeighbors = twoDArray.whoAreMyNeighbors((20,20))
        print (optionalNeighbors)
        if let neighbor = optionalNeighbors {
            print(neighbor)
        }
        
        //Another Version of If let used earlier
        guard let neighbor = twoDArray.whoAreMyNeighbors((0,0))
            else {
                print ("Not present")
                return
        }
        
        print (neighbor)
        
        if arc4random_uniform(3) == 1 {
            // set current cell to alive
        }*/
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
