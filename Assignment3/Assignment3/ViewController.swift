//
//  ViewController.swift
//  Assignment3
//
//  Created by Angel Henderson on 7/5/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var gridView: GridView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func runButtonAction(sender: AnyObject) {
        
        gridView.grid = step(gridView.grid)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

