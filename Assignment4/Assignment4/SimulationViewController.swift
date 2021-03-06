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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.actionTimerNotification(_:)), name: "timerNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.updateGridNotification(_:)), name: "updateGridNotification", object: nil)

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
        gameEngine.grid = gameEngine.step()
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }
    
    func stopTimerNotification (notification:NSNotification){
        gameEngine.grid = gameEngine.step()
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }
    
    func updateGridNotification (notification:NSNotification){
        let userInfo: Dictionary = (notification.userInfo as? Dictionary< String, Grid >)!
        let withGrid = userInfo["grid"]
        gameEngine.grid = withGrid!
        gridView.grid = gameEngine.grid
        gridView.setNeedsDisplay()
    }

    func engineDidUpdate(withGrid: Grid) {
        let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo: ["grid": withGrid])
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

