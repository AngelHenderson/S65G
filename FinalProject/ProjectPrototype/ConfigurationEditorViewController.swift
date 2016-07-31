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
        
        gridView.points = jsonContent.isEmpty ? [] : jsonContent.map{Array in (Array[0],Array[1])}
    }

    @IBAction func saveButtonPressed(button: UIButton) {
        let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo:nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
        
        let mappedArray = gridView.points.map { [$0.0,$0.1] }
        if let commitPoints = commitPoints {
            commitPoints(mappedArray)
        }
        if let commit = commit {
            commit(titleTextField.text!)
        }


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
