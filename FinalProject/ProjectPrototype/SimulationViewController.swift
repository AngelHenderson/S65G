
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    var gameEngine: EngineProtocol!
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var runButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StandardEngine.sharedInstance.rows = 10
        StandardEngine.sharedInstance.cols = 10
        gameEngine = StandardEngine.sharedInstance
        gameEngine.delegate = self

        let e = gameEngine.grid[1,1]
        print ("\(e)")
        
//      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.updateGridNotification(_:)), name: "updateGridNotification", object: nil)
//        
//      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.actionTimerNotification(_:)), name: "timerNotification", object: nil)

    }

    func engineDidUpdate(withGrid: GridProtocol) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

