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
    
        let twoDArray = TwoDimensional(height: 5, width: 10)
        twoDArray.printMyArray()
        twoDArray.somethingElse()
        let nStatus = NeighborStatus.alive
        let color = TwoDimensional.Colors.Red
        
        let origin = CellIndex(height: 0, width: 0)
        
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
    }
    
    
    @IBAction func runButtonAction(sender: AnyObject) {
        textView.text = "Hello, this button seems to be working as intended"
        if arc4random_uniform(3) == 1 {
            // set current cell to alive
        }
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
