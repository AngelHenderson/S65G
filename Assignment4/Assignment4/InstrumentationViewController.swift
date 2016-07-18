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

    @IBOutlet weak var timeIntervalTextField: UITextField!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var rowCountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine = StandardEngine.sharedInstance

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func increment(sender: AnyObject) {
        gameEngine.rows += 10
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

