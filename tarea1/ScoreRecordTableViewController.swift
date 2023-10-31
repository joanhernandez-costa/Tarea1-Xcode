
import UIKit

class ScoreRecordTableViewController: UITableViewController {

    @IBOutlet var scoreRecordTableView: UITableView!
    
    static var scoreRecord: [Game] = [Game(userName: "Jugador", score: 0.0, durationOfGame: "Tiempo", dateOfTheGame: "Fecha")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        ScoreRecordTableViewController.scoreRecord.append(SaveLoad.readGame())
        
        scoreRecordTableView.dataSource = self
        scoreRecordTableView.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreRecordTableViewController.scoreRecord.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreRecordCell", for: indexPath) as! ScoreTableViewCell
        let gameInPosition = ScoreRecordTableViewController.scoreRecord[indexPath.item]
        
        cell.userNameTableCellLabel.text = gameInPosition.userName
        cell.scoreTableCellLabel.text = String(gameInPosition.score)
        cell.durationTableCellLabel.text = gameInPosition.durationOfGame
        cell.dateTableCellLabel.text = gameInPosition.dateOfTheGame

        return cell
    }
}
