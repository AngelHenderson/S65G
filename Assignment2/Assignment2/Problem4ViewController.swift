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

        self.title = "Problem 4"

        // Do any additional setup after loading the view.
    }

    @IBAction func runButtonAction(sender: AnyObject) {
        var beforeTwoDBoolArray = Array<Array<Bool>>()
        var afterTwoDBoolArray = Array<Array<Bool>>()
        var aliveCount = 0
        var afterAliveCount = 0
        
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
        
        //Before Alive Count
        for arrayOfBool in beforeTwoDBoolArray {
            for boolValue in arrayOfBool {
                aliveCount += ((boolValue == true) ? 1 : 0)
            }
        }
        
        
        //Steps Function
        afterTwoDBoolArray = step2(beforeTwoDBoolArray)
        
        
        //After Alive Count
        for arrayOfBool in afterTwoDBoolArray {
            for boolValue in arrayOfBool {
                afterAliveCount += ((boolValue == true) ? 1 : 0)
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
