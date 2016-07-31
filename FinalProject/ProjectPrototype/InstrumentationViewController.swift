
import UIKit

class InstrumentationViewController: UIViewController {

    var gameEngine: EngineProtocol!
    @IBOutlet weak var rowCountTextField: UITextField!
    @IBOutlet weak var colCountTextField: UITextField!

    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var rowStepper: UIStepper!

    @IBOutlet weak var mainSlider: UISlider!
    @IBOutlet var refreshSwitch: UISwitch!

    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var editBarItem: UIBarButtonItem!

    @IBOutlet var alert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Standard Engine Set
        gameEngine = StandardEngine._sharedInstance
        refreshUI(gameEngine)
        
        //AlertView for Checking Empty Textfield
        alert = UIAlertController(title: "Empty Url", message: "The url must be provided to pull in data. We will restore the default url.", preferredStyle: UIAlertControllerStyle.Alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            self.urlTextField.text = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"
        }))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.editButtonUpdate(_:)), name: "editingNotification", object: nil)
    }

    override func viewDidAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   // MARK: - Actions

    @IBAction func increment(sender: UIStepper) {
        if sender == rowStepper {
            gameEngine.rows = Int(sender.value)
            rowCountTextField.text  = String(StandardEngine.sharedInstance.rows)
        } else {
            gameEngine.cols = Int(sender.value)
            colCountTextField.text  = String(StandardEngine.sharedInstance.cols)
        }
        refreshUI(gameEngine)
    }
    
    @IBAction func sliderChanged(slider: UISlider) {
        gameEngine.refreshRate = Double(slider.value)
        refreshUI(gameEngine)
    }
    
    @IBAction func switchIsChanged(sender:UISwitch) {
        gameEngine.runTimer = sender.on
        refreshUI(gameEngine)
    }

    @IBAction func reloadAction(sender: AnyObject) {
        let notification = NSNotification(name: "updateSourceNotification", object:nil, userInfo:["url": urlTextField.text!])
        //Bonus: Check for Empty Textfield
        urlTextField.text != "" ? NSNotificationCenter.defaultCenter().postNotification(notification) : self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func addAction(sender: UIBarButtonItem) {
        let notification = NSNotification(name: "addToTableNotification", object:nil, userInfo:nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    @IBAction func editAction(sender: UIBarButtonItem) {
        let notification = NSNotification(name: "editTableNotification", object:nil, userInfo:nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    func editButtonUpdate(notification:NSNotification) {
        if let userInfo = notification.userInfo {
            let editTitle: String! = (userInfo["setEditing"]! as! Bool) == true ? "Done" : "Edit"
            self.editBarItem.title = editTitle
        }
    }
    
    // MARK: - Private Methods
    private func refreshUI(engine: EngineProtocol) {
        // Populate the values from the engine
        rowStepper.value = Double(engine.rows)
        colStepper.value = Double(engine.cols)
        rowCountTextField.text = engine.rows.description
        colCountTextField.text = engine.cols.description
        mainSlider.value = Float(engine.refreshRate)
        refreshSwitch.on = engine.runTimer
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    }
    
    
}

