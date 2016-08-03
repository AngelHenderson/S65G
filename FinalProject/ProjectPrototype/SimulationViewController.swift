
import UIKit
import AVFoundation

class SimulationViewController: UIViewController, EngineDelegate {

    var gameEngine: EngineProtocol!
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    @IBOutlet weak var titleTextfield: UITextField!

    @IBOutlet weak var pacSwitch: UISwitch!
    @IBOutlet weak var pacModeLabel: UILabel!
    
    @IBOutlet weak var pacmanView: PacmanView!
    
    var pacmanPosition:(Int,Int) = (3,3)

    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pacmanView.backgroundColor = UIColor.blackColor()
        gameEngine = StandardEngine._sharedInstance
        gameEngine.delegate = self

        pacmanView.PacmanPoints = [pacmanPosition]
//        let e = gameEngine.grid[1,1]
//        print ("\(e)")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.updateGridNotification(_:)), name: "updateGridNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(movePacManNotification(_:)), name: "movePacManNotification", object: nil)

    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        gridView.setNeedsDisplay()
        pacmanView.setNeedsDisplay()
    }

    func updateGridNotification (notification:NSNotification){
        gridView.setNeedsDisplay()
        if pacSwitch.on {
            pacmanView.setNeedsDisplay()
        }
    }
    
    func movePacManNotification (notification:NSNotification){
        if pacSwitch.on {
            self.movePacMan()
            pacmanView.setNeedsDisplay()
        }
    }
    
    @IBAction func runButtonAction(sender: AnyObject) {
        gameEngine.step()
        self.movePacMan()
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
        
        //Pac-Man Reset
        self.resetPacMan()
    }
    
    // MARK: - Pacman Functions

    @IBAction func pacmanModeTapped(sender: AnyObject) {
        
        //Pac-Man Reset
        self.resetPacMan()
        
        //Play Audio
        if sender.on == true {
            let path = NSBundle.mainBundle().pathForResource("Pacmanbegin", ofType:"wav")!
            let url = NSURL(fileURLWithPath: path)
            do {
                let sound = try AVAudioPlayer(contentsOfURL: url)
                audioPlayer = sound
                sound.play()
            } catch {
                // couldn't load file :(
            }
        }
        
        //Updates UI and brings Pac-Man View Forward
        let buttonColor: UIColor = sender.on == true ? UIColor(red:0.42, green:0.42, blue:0.43, alpha:1.00) : UIColor.groupTableViewBackgroundColor()
        let backgroundColor: UIColor = sender.on == true ? UIColor(red:0.08, green:0.08, blue:0.09, alpha:1.00) : UIColor.whiteColor()
        let labelColor: UIColor = sender.on == true ? UIColor(red:0.78, green:0.78, blue:0.79, alpha:1.00) : UIColor.darkGrayColor()
        let textColor: UIColor = sender.on == true ? UIColor.whiteColor() : UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.00)
        
        view.backgroundColor = backgroundColor
        saveButton.backgroundColor = buttonColor
        restButton.backgroundColor = buttonColor
        runButton.backgroundColor = buttonColor
        saveButton.setTitleColor(textColor, forState: UIControlState.Normal)
        restButton.setTitleColor(textColor, forState: UIControlState.Normal)
        runButton.setTitleColor(textColor, forState: UIControlState.Normal)
        pacModeLabel.textColor = labelColor
        
        self.pacmanView.alpha = sender.on == true ? 1 : 0
        self.gridView.alpha = sender.on == true ? 0 : 1
    }
    


    
    //Handles Pac-Man's Movements
    func movePacMan() {
        if pacSwitch.on == true {
            
            //Play Audio
            let path = NSBundle.mainBundle().pathForResource("Pacmanchomp", ofType:"wav")!
            let url = NSURL(fileURLWithPath: path)
            do {
                let sound = try AVAudioPlayer(contentsOfURL: url)
                audioPlayer = sound
                sound.play()
            } catch {
                // couldn't load file :(
            }
        
            for element in pacmanView.PacmanPoints {
                //print(element)
            }
            let nextPosition: Int = pacmanPosition.1 + 1
            pacmanPosition = (pacmanPosition.0,nextPosition)
            pacmanView.PacmanPoints = [pacmanPosition]
            
        }
    }
    
    func resetPacMan() {
        //Pac-Man Reset
        pacmanPosition = (3,3)
        pacmanView.PacmanPoints = [pacmanPosition]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

