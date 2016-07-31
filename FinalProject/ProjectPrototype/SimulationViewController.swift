
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    var gameEngine: EngineProtocol!
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    var points:[(Int,Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        gameEngine = StandardEngine._sharedInstance
        gameEngine.delegate = self

        gridView.points = [(0,0),(1,1),(2,2),(3,3)]
        
//        let e = gameEngine.grid[1,1]
//        print ("\(e)")

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.updateGridNotification(_:)), name: "updateGridNotification", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        print("The withGrid")
        gridView.setNeedsDisplay()
    }

    func updateGridNotification (notification:NSNotification){
        //gridView.setNeedsDisplay()
        print("Upgrade Notification")
    }
    
    
    @IBAction func runButtonAction(sender: AnyObject) {
    }
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        
    }
    
    @IBAction func resetButtonAction(sender: AnyObject) {
        gridView.points = []
        let notification = NSNotification(name: "resetNotification", object:nil, userInfo:nil)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

