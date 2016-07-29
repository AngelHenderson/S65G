
import UIKit

class StatisticsViewController: UIViewController {

    var gameEngine: EngineProtocol!

    @IBOutlet weak var livingCellCount: UILabel!
    @IBOutlet weak var bornCellCount: UILabel!
    @IBOutlet weak var deadCellCount: UILabel!
    @IBOutlet weak var emptyCellCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameEngine = StandardEngine._sharedInstance
        countCells(StandardEngine._sharedInstance.grid)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsViewController.cellCountNotification(_:)), name: "updateGridNotification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cellCountNotification (notification:NSNotification){
        if let userInfo = notification.userInfo {
            let withGrid = (userInfo["grid"] as! GridView.GridChangedNotification).myGridProtocol
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
