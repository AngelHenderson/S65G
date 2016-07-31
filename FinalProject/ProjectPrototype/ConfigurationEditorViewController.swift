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


    var gridToEdit : String = ""

    /// Closure that can be triggered on the save
    var commit: (String -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save,target: self,action: #selector(saveButtonPressed))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel,target: self,action: #selector(cancelButtonPressed))
    }
    
    override func viewWillAppear(animated: Bool) {
        // Change the title
        title = "Editing: \(gridToEdit)"
        print(gridToEdit)

        // Refresh the name of the Grid to edit
        titleTextField.text = gridToEdit
        
        textView.text = textView.text + "JSON Content"
        textView.text = textView.text + "\n" + "\n" + jsonTitle
        textView.text = textView.text + " : " + jsonContent.description

        
        // Set it to be editing now
        //titleTextField.becomeFirstResponder()
    }

    
    @IBAction func saveButtonPressed(button: UIButton) {
        print("Print Saved")

        if let commit = commit {
            commit(titleTextField.text!)
        }
    }
    
    @IBAction func cancelButtonPressed(button: UIButton) {
        print("Pop Navigation")
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
