
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    var gameEngine: EngineProtocol!
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    @IBOutlet weak var titleTextfield: UITextField!

    var points:[(Int,Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        gameEngine = StandardEngine._sharedInstance
        gameEngine.delegate = self

        //gridView.points = [(0,0),(1,1),(2,2),(3,3)]
//        let e = gameEngine.grid[1,1]
//        print ("\(e)")

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.updateGridNotification(_:)), name: "updateGridNotification", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        //print("The withGrid")
        gridView.setNeedsDisplay()
    }

    func updateGridNotification (notification:NSNotification){
        gridView.setNeedsDisplay()
       // print("Upgrade Notification")
    }
    
    
    @IBAction func runButtonAction(sender: AnyObject) {
        gameEngine.step()
    }
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        
        var inputTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Grid Name?", message: "Please provide a name for your grid configuration. If left empty the default name will be New Grid.", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        }
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            //Saved Current Points with Given Title
            let mappedArray = self.gridView.points.map { [$0.0,$0.1] }
            let notification = NSNotification(name: "addToTableNotification", object:nil, userInfo:["title":inputTextField!.text!,"points":mappedArray])
            NSNotificationCenter.defaultCenter().postNotification(notification)
            
            //Alerts User the GridView was Saved
            let alert = UIAlertController(title: "Grid Saved", message: "Your Grid can be accessed in the Instrumentation Tab", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(nextAction)
        
        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            // Saves text field
            inputTextField = textField
        }
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func resetButtonAction(sender: AnyObject) {
        gridView.points = []
        let notification = NSNotification(name: "updateGridNotification", object:nil, userInfo:["grid":GridProtocolWrapper(s: StandardEngine.sharedInstance.grid)])
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

