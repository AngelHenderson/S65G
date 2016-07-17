//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Angel Henderson on 7/15/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController {

    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var runButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func runButtonAction(sender: AnyObject) {
        
      //  gridView.grid = step(gridView.grid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

