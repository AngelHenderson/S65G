//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Angel Henderson on 7/15/16.
//  Copyright © 2016 Angel Henderson. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var livingCellCount: UILabel!
    @IBOutlet weak var bornCellCount: UILabel!
    @IBOutlet weak var deadCellCount: UILabel!
    @IBOutlet weak var emptyCellCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //NSNotification for Counting Each Cell Type
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsViewController.cellCountNotification(_:)), name: "cellCountNotification", object: nil)    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cellCountNotification (notification:NSNotification){
        let userInfo: Dictionary = (notification.userInfo as? Dictionary< String, AnyObject >)!

        let livingCountString = userInfo["livingCount"]
        livingCellCount.text = String(livingCountString!)
        
        let bornCountString = userInfo["bornCount"]
        bornCellCount.text = String(bornCountString!)
        
        let deadCountString = userInfo["deadCount"]
        deadCellCount.text = String(deadCountString!)
        
        let emptyCountString = userInfo["emptyCount"]
        emptyCellCount.text = String(emptyCountString!)
    }

}
