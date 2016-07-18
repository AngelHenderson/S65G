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

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.updateGrid(_:)), name: "updateGridNotification", object: nil)
        
        let sel = #selector(SimulationViewController.actionTimerNotification(_:))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: "FireTimerNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        gameEngine = StandardEngine.sharedInstance
        gameEngine.delegate = self
        gridView.grid = gameEngine.grid
        gridView.rows = gameEngine.rows
        gridView.cols = gameEngine.cols
        
        print("Grid updated with \(gridView.rows)")
        gridView.setNeedsDisplay()


    }

    
    @IBAction func runButtonAction(sender: AnyObject) {
        gameEngine.grid = gameEngine.step()
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }
    
    func actionTimerNotification (notification:NSNotification){
        gameEngine.grid = gameEngine.step()
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }
    
    func updateGrid (notification:NSNotification){
        print("Update Grid Notification Added")
    }
    
    func engineDidUpdate(withGrid: Grid) {
        
        gameEngine.grid = withGrid
        gridView.grid = gameEngine.grid
        
       // print("Grid updated with \(gridView.grid.rows)")


       // gridView.grid = withGrid
        gridView.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

