
import UIKit

class ScoreRecordTableViewController: UITableViewController {

    @IBOutlet var scoreRecordTableView: UITableView!
    
    static var scoreRecord: [GameData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreRecordTableView.dataSource = self
        scoreRecordTableView.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreRecordTableViewController.scoreRecord.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreRecordCell", for: indexPath) as! ScoreTableViewCell
        let gameInPosition = ScoreRecordTableViewController.scoreRecord[indexPath.item]
        
        cell.userNameTableCellLabel.text = gameInPosition.data.userName
        cell.scoreTableCellLabel.text = String(gameInPosition.data.score)
        cell.durationTableCellLabel.text = gameInPosition.data.durationOfGame
        cell.dateTableCellLabel.text = gameInPosition.data.dateOfTheGame

        return cell
    }
}
