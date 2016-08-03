
import UIKit

class StatisticsViewController: UIViewController {

    var gameEngine: EngineProtocol!

    @IBOutlet weak var livingCellCount: UILabel!
    @IBOutlet weak var bornCellCount: UILabel!
    @IBOutlet weak var deadCellCount: UILabel!
    @IBOutlet weak var emptyCellCount: UILabel!
    
    @IBOutlet weak var livingLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var deadLabel: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        livingLabel.textColor = UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.00)
        bornLabel.textColor = UIColor(red:0.40, green:0.70, blue:0.40, alpha:1.00)
        deadLabel.textColor = UIColor(red:0.64, green:0.64, blue:0.64, alpha:1.00)
        emptyLabel.textColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.00)
        
        gameEngine = StandardEngine._sharedInstance
        countCells(StandardEngine._sharedInstance.grid)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.cellCountNotification(_:)), name: "updateGridNotification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cellCountNotification (notification:NSNotification){
        if let userInfo = notification.userInfo {
            let withGrid = (userInfo["grid"] as! GridProtocolWrapper).grid
            countCells(withGrid)
        }
    }
    
    func countCells (grid:GridProtocol){
        var aliveCount: Int = 0
        var bornCount: Int = 0
        var deadCount: Int = 0
        var emptyCount: Int = 0
        
        for row in 0..<grid.rows {
            for col in 0..<grid.cols {
                grid[row,col] == .Alive ? aliveCount += 1 : grid[row,col] == .Born ? bornCount += 1 : grid[row,col] == .Died ? deadCount += 1 : (emptyCount += 1)
            }
        }
        
        livingCellCount.text = String(aliveCount)
        bornCellCount.text = String(bornCount)
        deadCellCount.text = String(deadCount)
        emptyCellCount.text = String(emptyCount)
        
    }
}
