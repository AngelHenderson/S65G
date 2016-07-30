
import UIKit

class InstrumentationViewController: UIViewController {

    var gameEngine: EngineProtocol!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var rowCountTextField: UITextField!
    var incrementValue: Double = 0.0
    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var colCountTextField: UITextField!
    var colIncrementValue: Double = 0.0
    @IBOutlet weak var mainSlider: UISlider!
    
    private var names:Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine = StandardEngine._sharedInstance
        //incrementValue = rowStepper.value
        //ncrementValue = colStepper.value
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func increment(sender: UIStepper) {
        if sender == rowStepper {
            Double(sender.value) < incrementValue ? (StandardEngine.sharedInstance.rows -= 10) : (StandardEngine.sharedInstance.rows += 10)
            incrementValue = sender.value
            rowCountTextField.text  = String(StandardEngine.sharedInstance.rows)
        }
        else{
            Double(sender.value) < colIncrementValue ? (StandardEngine.sharedInstance.cols -= 10) : (StandardEngine.sharedInstance.cols += 10)
            colIncrementValue = sender.value
            colCountTextField.text  = String(StandardEngine.sharedInstance.cols)
        }
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

