//
//  FirstViewController.swift
//  Assignment4
//
//  Created by Angel Henderson on 7/15/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    var gameEngine: StandardEngine!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var rowCountTextField: UITextField!
    var incrementValue: Double = 0.0
    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var colCountTextField: UITextField!
    var colIncrementValue: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine = StandardEngine.sharedInstance
        incrementValue = rowStepper.value
        incrementValue = colStepper.value

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func increment(sender: UIStepper) {
        print(Int(sender.value).description)
        
        if Double(sender.value) < incrementValue {
            StandardEngine.sharedInstance.rows -= 10
        }
        else {
            StandardEngine.sharedInstance.rows += 10
        }
        
        incrementValue = sender.value
        rowCountTextField.text  = String(StandardEngine.sharedInstance.rows)
    }
    
    @IBAction func colIncrement(sender: UIStepper) {
        print(Int(sender.value).description)
        
        if Double(sender.value) < colIncrementValue {
            StandardEngine.sharedInstance.cols -= 10
        }
        else {
            StandardEngine.sharedInstance.cols += 10
        }
        
        colIncrementValue = sender.value
        colCountTextField.text  = String(StandardEngine.sharedInstance.cols)
    }
    
    @IBAction func switchIsChanged(sender:UISwitch) {
        if sender.on {
            let notification = NSNotification(name: "switchNotification", object: nil, userInfo: ["switchOn": true])
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
        else {
            let notification = NSNotification(name: "switchNotification", object: nil, userInfo: ["switchOn": false])
            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
    
    func sliderValueChanged(sender: UISlider) {
        let currentValue = Double(sender.value)
        print (currentValue)
        StandardEngine.sharedInstance.refreshInterval = currentValue
    }
    
    @IBAction func updateTimeInterval(sender: UITextField) {
        if let text = sender.text,
            interval = Double(text)  {
            gameEngine.refreshInterval = interval
        }
        else  {
            gameEngine.refreshInterval = 0
        }
    }
    


}

