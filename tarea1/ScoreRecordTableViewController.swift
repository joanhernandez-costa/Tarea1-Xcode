
import UIKit

class ScoreRecordTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var scoreRecordTableView: UITableView!
    
    @IBOutlet weak var scoreRecordHeaderView: UIView!
    @IBOutlet var headerTitlesButtons: [UIButton]!
    
    //Lista para almacenar todas las partidas jugadas.
    static var scoreRecord: [GameData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreRecordHeaderView.backgroundColor = .gray
        scoreRecordTableView.tableHeaderView = scoreRecordHeaderView
        
        scoreRecordTableView.dataSource = self
        scoreRecordTableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreRecordTableViewController.scoreRecord.count
    }
    
    //Se ejecuta cada vez que se quiere dibujar una celda, se crea la celda y se rellena con el contenido de cada partida.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreRecordCell", for: indexPath) as! ScoreTableViewCell
        let gameInPosition = ScoreRecordTableViewController.scoreRecord[indexPath.item]
        
        cell.userNameTableCellLabel.text = gameInPosition.data.userName
        cell.scoreTableCellLabel.text = String(gameInPosition.data.score)
        cell.durationTableCellLabel.text = gameInPosition.data.durationOfGame
        cell.dateTableCellLabel.text = gameInPosition.data.dateOfTheGame

        return cell
    }
    
    @IBAction func onTitleButtonsTapped(_ sender: UIButton) {
        print("tapped on '" + String((sender.titleLabel?.text!)!) + "' button")
        let orderCriteria = OrderCriteria()
        
        switch sender.titleLabel?.text! {
        case "Jugador":
            ScoreRecordTableViewController.scoreRecord = orderCriteria.orderByScore()
        case "Puntuacion":
            print("")
        case "Tiempo":
            print("")
        case "Fecha":
            print("")
        default:
            print("")
        }
    }
    
}
