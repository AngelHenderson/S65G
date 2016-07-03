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

        self.title = "Problem 3"

        // Do any additional setup after loading the view.
    }

    @IBAction func runButtonAction(sender: AnyObject) {
        
        let twoDArray = TwoDimensional(height: 10, width: 10)
        
        print (twoDArray)
        
        var beforeTwoDBoolArray = Array<Array<Bool>>()
        
        let height : Int
        let width : Int
        
        height = 10
        width = 10
        
        beforeTwoDBoolArray = Array (count: height, repeatedValue: Array(count: width, repeatedValue: false))
        
        step(beforeTwoDBoolArray)

        /*twoDArray.printMyArray()
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
         
         optionalNeighbors = twoDArray.whoAreMyNeighbors((5,5))
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
         
         print (neighbor)*/
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
