
import UIKit

class InstrumentationViewController: UIViewController {

    var gameEngine: EngineProtocol!
    @IBOutlet weak var rowCountTextField: UITextField!
    @IBOutlet weak var colCountTextField: UITextField!

    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var rowStepper: UIStepper!

    @IBOutlet weak var mainSlider: UISlider!
    @IBOutlet var refreshSwitch: UISwitch!

    private var names:Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine = StandardEngine._sharedInstance
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
        // Validation isn't needed because slider can only go from
        // 0.1...10
        gameEngine.refreshRate = Double(slider.value)
        refreshUI(gameEngine)
    }
    
    @IBAction func switchIsChanged(sender:UISwitch) {

        let notification = NSNotification(name: "timerNotification", object: nil, userInfo: ["switchOn": true])
        NSNotificationCenter.defaultCenter().postNotification(notification)
        gameEngine.runTimer = sender.on

            //StandardEngine.sharedInstance.refreshInterval = Double(mainSlider.value)

        refreshUI(gameEngine)
    }
    
    // MARK: - Private Methods
    private func refreshUI(engine: EngineProtocol) {
        // Populate the values from the engine
        rowStepper.value = Double(engine.rows)
        colStepper.value = Double(engine.cols)
        rowCountTextField.text = engine.rows.description
        colCountTextField.text = engine.cols.description
        mainSlider.value = Float(engine.refreshRate)
    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let editingRow = (sender as! UITableViewCell).tag
//        let editingString = names[editingRow]
//        guard let editingVC = segue.destinationViewController as? EditViewController
//            else {
//                preconditionFailure("Another wtf?")
//        }
//        editingVC.name = editingString
//        editingVC.commit = {
//            self.names[editingRow] = $0
//            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
//            self.tableView.reloadRowsAtIndexPaths([indexPath],
//                                                  withRowAnimation: .Automatic)
//        }
    }
    
    
}

