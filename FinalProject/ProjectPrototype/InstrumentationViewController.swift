
import UIKit

class InstrumentationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var gameEngine: EngineProtocol!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var rowCountTextField: UITextField!
    var incrementValue: Double = 0.0
    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var colCountTextField: UITextField!
    var colIncrementValue: Double = 0.0
    @IBOutlet weak var mainSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameEngine = StandardEngine._sharedInstance
        //incrementValue = rowStepper.value
        //ncrementValue = colStepper.value
        
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
    
}

