//
//  ConfigurationViewController.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController {

    private var JSONArray:Array<GridData> = []
    private var userArray:Array<GridData> = []

    struct GridData {
        var title: String
        var contents: [[Int]]
        
        static func fromJSON(json: AnyObject) -> GridData {
            if let dict = json as? Dictionary<String, AnyObject> {
                let title = dict["title"] as! String
                let contents = dict["contents"] as! [[Int]]
                return GridData(title: title, contents: contents)
            }
            return GridData(title: "", contents: [])
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            
            if let message = message {
                if message.rangeOfString("Error") != nil {
                    //AlertView for Network Error
                    let alert:UIAlertController = UIAlertController(title: "HTTP Error Occured", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)                }
            }
            
            if let json = json {
                self.JSONArray = (json as! Array<AnyObject>).map({ element in
                    return GridData.fromJSON(element)
                })

                let op = NSBlockOperation {
                    self.tableView.reloadData()
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
        
        //Load Previous User Saved Grids
        var userArrayOfTitles:[String] = []
        var userArrayOfContents:[[[Int]]] = []
        
        if let userTitles = NSUserDefaults.standardUserDefaults().objectForKey("userArrayOfTitles"){
            userArrayOfTitles = userTitles as! [String]
        }
        
        if let userContents = NSUserDefaults.standardUserDefaults().objectForKey("userArrayOfContents"){
            userArrayOfContents = userContents as! [[[Int]]]
        }
        
        if userArrayOfTitles.isEmpty == false {
            for i in 0..<userArrayOfTitles.count {
                userArray.append(GridData(title: userArrayOfTitles[i], contents: userArrayOfContents[i]))
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateSource(_:)), name: "updateSourceNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.addButton(_:)), name: "addToTableNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.editButton(_:)), name: "editTableNotification", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.saveGridAction(_:)), name: "saveUserGridsNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: UITableViewDelegation
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount: Int = section == 0 ? JSONArray.count : userArray.count
        return rowCount
        //return JSONArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Default")
            else {
                preconditionFailure("missing Default reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("wtf?")
        }
        
        let rowTitle: String! = indexPath.section == 0 ? JSONArray[row].title : userArray[row].title
        nameLabel.text = rowTitle
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView,
                   commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                      forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Deletes Object from Local Array and Removes TableViewCell
            if indexPath.section == 0 { JSONArray.removeAtIndex(indexPath.row) }
            else{ userArray.removeAtIndex(indexPath.row) }
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.insertRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    


    func updateSource(notification:NSNotification) {
        if let urlString = notification.userInfo!["url"] as? String {
            //Empty Array and Reset Table
            self.JSONArray = []
            self.tableView.reloadData()

            //Fetch New Data from Url
            let url = NSURL(string: urlString)!
            let fetcher = Fetcher()
            fetcher.requestJSON(url) { (json, message) in
                if let json = json {
                    self.JSONArray = (json as! Array<AnyObject>).map({ element in
                        return GridData.fromJSON(element)
                    })
                    let op = NSBlockOperation {
                        self.tableView.reloadData()
                    }
                    NSOperationQueue.mainQueue().addOperation(op)
                }
            }
        }
    }
    
    // MARK: - Add Elements
    func addButton(notification:NSNotification) {
        if let message = notification.userInfo!["title"] as? String {
            message != "" ? userArray.append(GridData(title:notification.userInfo!["title"] as! String,contents: notification.userInfo!["points"] as! [[Int]])) : userArray.append(GridData(title:"New Grid",contents: []))
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "saveUserGridsNotification", object:nil, userInfo:nil))
        }
        let itemRow = userArray.count - 1
        let itemPath = NSIndexPath(forRow: itemRow, inSection: 1)
        tableView.insertRowsAtIndexPaths([itemPath],
                                         withRowAnimation: .Automatic)
        
        
    }
    
    
    // MARK: - Edit Elements
    func editButton(notification:NSNotification) {
        if (self.tableView.editing) {
            //editButton.title = "Edit"
            self.tableView.setEditing(false, animated: true)
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "editingNotification", object:nil, userInfo:["setEditing":false]))

        } else {
            //editButton.title = "Done"
            self.tableView.setEditing(true, animated: true)
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "editingNotification", object:nil, userInfo:["setEditing":true]))

        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        // Toggles the edit button state
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tableView.setEditing(editing, animated: true)
    }
    
    // MARK: - Save Elements
    func saveGridAction(notification:NSNotification) {
        var userArrayOfTitles:[String] = []
        var userArrayOfContents:[[[Int]]] = []

        for element in userArray{
            userArrayOfTitles.append(element.title)
            userArrayOfContents.append(element.contents)
        }

        NSUserDefaults.standardUserDefaults().setObject(userArrayOfTitles, forKey: "userArrayOfTitles")
        NSUserDefaults.standardUserDefaults().setObject(userArrayOfContents, forKey: "userArrayOfContents")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editSegue" {
            guard let editViewController = segue.destinationViewController as? ConfigurationEditorViewController,
                let tappedCell = sender as? UITableViewCell else {
                    print ("Not as expected")
                    return
            }

            let cell = sender as! UITableViewCell
            let indexPathForCell = tableView.indexPathForCell(cell)
            
            let editingRow = tappedCell.tag
           
            let jsonTitle: String = indexPathForCell!.section == 0 ? JSONArray[editingRow].title : userArray[editingRow].title
            let jsonContent: [[Int]]! = indexPathForCell!.section == 0 ? JSONArray[editingRow].contents : userArray[editingRow].contents
            editViewController.gridToEdit = jsonTitle
            editViewController.jsonTitle = jsonTitle
            editViewController.jsonContent = jsonContent

            editViewController.commitPoints = {
                // Update the row
                if indexPathForCell!.section == 0 { self.JSONArray[editingRow].contents = $0 }
                else { self.userArray[editingRow].contents = $0 }
            }
            
            editViewController.commit = {
                let cell = sender as! UITableViewCell
                let indexPathForCell = self.tableView.indexPathForCell(cell)
                // Update the row
                if indexPathForCell!.section == 0 {
                    self.JSONArray[editingRow].title = $0
                    // Refresh the cells in the tableview
                    let indexPath = NSIndexPath(forRow: editingRow,
                                                inSection: 0)
                    self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                          withRowAnimation: .Automatic)
                }
                else {
                    self.userArray[editingRow].title = $0
                    // Refresh the cells in the tableview
                    let indexPath = NSIndexPath(forRow: editingRow,
                                                inSection: 1)
                    self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                          withRowAnimation: .Automatic)
                }
   
                // Pop the view controller back to this
                self.navigationController?.popViewControllerAnimated(false)
            }
        }
    }
 

}
