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
    //private var names:Array<String> = []

    struct GridData {
        var title: String
        let contents: [[Int]]
        
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

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.updateSource(_:)), name: "updateSourceNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: UITableViewDelegation
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONArray.count
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
        nameLabel.text = JSONArray[row].title
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView,
                   commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                      forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Deletes Object from Local Array and Removes TableViewCell
            JSONArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            //JSONArray.removeAtIndex(indexPath.row)
            tableView.insertRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    
    
    @IBAction func addGridType(sender: AnyObject) {
//        JSONArray.append("Add new name...")
        let itemRow = JSONArray.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
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
            let editingRow = tappedCell.tag
    //        print(editViewController.gridToEdit)
     //       print(JSONArray[editingRow])
            editViewController.gridToEdit = JSONArray[editingRow].title
            editViewController.jsonTitle = JSONArray[editingRow].title
            editViewController.jsonContent = JSONArray[editingRow].contents

            editViewController.commit = {
                // Update the row
                self.JSONArray[editingRow].title = $0
                // Refresh the cells in the tableview
                let indexPath = NSIndexPath(forRow: editingRow,
                                            inSection: 0)
                self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                      withRowAnimation: .Automatic)
                // Pop the view controller back to this
                self.navigationController?.popViewControllerAnimated(false)
            }
        }
    }
 

}
