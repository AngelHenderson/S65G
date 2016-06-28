//
//  ViewController.swift
//  Lecture3
//
//  Created by Angel Henderson on 6/27/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonClicked(sender: AnyObject) {
        print("We were clicked")
    }
    
    //Can be nil but guarantees the complier that it wont be in the future
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

