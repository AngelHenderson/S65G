//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Angel Henderson on 7/15/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegateProtocol {
    
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var runButton: UIButton!
    var gameEngine: StandardEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine = StandardEngine.sharedInstance
        gameEngine.delegate = self
        gridView.grid = gameEngine.grid
        
        let sel = #selector(SimulationViewController.actionTimerNotification(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: "timerNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        gridView.setNeedsDisplay()
    }

    
    @IBAction func runButtonAction(sender: AnyObject) {
        gameEngine.grid = gameEngine.step()
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }
    
    func actionTimerNotification (notification:NSNotification){
        print("Timer went off")
        gameEngine.grid = gameEngine.step()
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }

    func engineDidUpdate(withGrid: Grid) {
        gameEngine.grid = withGrid
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

