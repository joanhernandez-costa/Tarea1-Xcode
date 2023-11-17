
import UIKit

class ScoreRecordTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var scoreRecordTableView: UITableView!
    
    @IBOutlet weak var scoreRecordHeaderView: UIView!
    @IBOutlet var headerTitlesButtons: [UIButton]!
    
    //Lista para almacenar todas las partidas jugadas.
    static var scoreRecordToShow: [GameData] = []
    static var sortedScoreRecord: [GameData] = ScoreRecordTableViewController.scoreRecordToShow
    let orderCriteria = OrderCriteria()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreRecordHeaderView.backgroundColor = .gray
        scoreRecordTableView.tableHeaderView = scoreRecordHeaderView
        
        scoreRecordTableView.dataSource = self
        scoreRecordTableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScoreRecordTableViewController.scoreRecordToShow.count
    }
    
    //Se ejecuta cada vez que se quiere dibujar una celda, se crea la celda y se rellena con el contenido de cada partida.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreRecordCell", for: indexPath) as! ScoreTableViewCell
        let gameInPosition = ScoreRecordTableViewController.scoreRecordToShow[indexPath.item]
        
        cell.userNameTableCellLabel.text = gameInPosition.data.userName
        cell.scoreTableCellLabel.text = String(gameInPosition.data.score)
        cell.durationTableCellLabel.text = gameInPosition.data.durationOfGame
        cell.dateTableCellLabel.text = gameInPosition.data.dateOfTheGame

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    @IBAction func onTitleButtonsTapped(_ sender: UIButton) {
        
        let titlePressed = sender.titleLabel?.text!
        let indexOfTitlePressed = headerTitlesButtons.firstIndex(of: sender)!
        
        switch titlePressed {
        case "Jugador":
            ScoreRecordTableViewController.scoreRecordToShow = orderCriteria.orderByUserName(indexOfTitlePressed: indexOfTitlePressed)
        case "Puntuacion":
            ScoreRecordTableViewController.scoreRecordToShow = orderCriteria.orderByScore(indexOfTitlePressed: indexOfTitlePressed)
        case "Tiempo":
            ScoreRecordTableViewController.scoreRecordToShow = orderCriteria.orderByTime(indexOfTitlePressed: indexOfTitlePressed)
        case "Fecha":
            ScoreRecordTableViewController.scoreRecordToShow = orderCriteria.orderByDate(indexOfTitlePressed: indexOfTitlePressed)
        default:
            print("Error en criterio de ordenación")
        }
        print(titlePressed!)
        scoreRecordTableView.reloadData()
    }
    
}
