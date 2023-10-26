import UIKit

class YourScoreViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameDurationLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let game: Game = SaveLoad.readGame()
        
        userNameLabel.text = game.userName
        scoreLabel.text = String(game.score)
        gameDurationLabel.text = String(game.durationOfGame)
        gameDateLabel.text = game.dateOfTheGame
    }

}
