//
//  ConfigurationEditorViewController.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class ConfigurationEditorViewController: UIViewController {
    
    @IBOutlet var titleTextField : UITextField!
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var textView: UITextView!

    var jsonTitle: String!
    var jsonContent: [[Int]]!
    var originalPoints: [(Int,Int)]!

    var gridToEdit : String = ""

    /// Closure that can be triggered on the save
    var commit: (String -> Void)?
    var commitPoints: ([[Int]] -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Standard Engine Set
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save,target: self,action: #selector(saveButtonPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel,target: self,action: #selector(cancelButtonPressed))
    }
    
    override func viewWillAppear(animated: Bool) {
        // Change the title
        title = "Editing: \(gridToEdit)"

        // Refresh the name of the Grid to edit
        titleTextField.text = gridToEdit
        textView.text = textView.text + "JSON Content"
        textView.text = textView.text + "\n" + "\n" + jsonTitle
        textView.text = textView.text + " : " + jsonContent.description
        
        //Save Original State of Points
        originalPoints = gridView.points
        
        //Determine Grid Size Required
        let maxSize = jsonContent.flatMap {$0}.reduce(0) {
            $0 > $1 ? $0 : $1
        }
        
        //Round to Nearest 10
        let nearestTen: Int = 10 * Int(ceil(Double(maxSize) / 10.0))
        print(nearestTen)
        //If New Grid then ignore changing Grid Size
        if maxSize > 0 {
            StandardEngine.sharedInstance.rows = Int(nearestTen)
            StandardEngine.sharedInstance.cols = Int(nearestTen)
        }


        gridView.points = jsonContent.isEmpty ? [] : jsonContent.map{Array in (Array[0],Array[1])}
    }

    @IBAction func saveButtonPressed(button: UIButton) {
        
        let maxSize = jsonContent.flatMap {$0}.reduce(0) {
            $0 > $1 ? $0 : $1
        }

        //Round to Nearest 10
        let nearestTen: Int = 10 * Int(ceil(Double(maxSize) / 10.0))
        
        //Save User Settings
        NSUserDefaults.standardUserDefaults().setInteger(Int(nearestTen), forKey: "rows")
        NSUserDefaults.standardUserDefaults().setInteger(Int(nearestTen), forKey: "cols")
        
        let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo:["grid":GridProtocolWrapper(s: StandardEngine.sharedInstance.grid)])
        NSNotificationCenter.defaultCenter().postNotification(notification)
        
        let mappedArray = gridView.points.map { [$0.0,$0.1] }
        if let commitPoints = commitPoints {
            commitPoints(mappedArray)
        }
        if let commit = commit {
            commit(titleTextField.text!)
        }

        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "saveUserGridsNotification", object:nil, userInfo:nil))
    }
    
    @IBAction func cancelButtonPressed(button: UIButton) {
        //Restores Original State if Canceled
        gridView.points = originalPoints
        self.navigationController?.popViewControllerAnimated(true)
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
