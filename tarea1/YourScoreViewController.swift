import UIKit

class YourScoreViewController: UIViewController {
    
    @IBOutlet weak var cardOrderComprobationStack: UIStackView!
    @IBOutlet weak var userOrderComprobationStack: UIStackView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameDurationLabel: UILabel!
    @IBOutlet weak var gameDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScoreData()
        
        //Muestra un StackView con las imágenes en el orden en que se han mostrado
        for i in 0 ..< currentSettings.numberOfCards {
            let imageView = setComprobationImages(order: cardOrder, i: i)
            cardOrderComprobationStack.addArrangedSubview(imageView)
        }
        
        //Muestra un StackView con las imágenes en el orden que ha elegido el usuario.
        for i in 0 ..< currentSettings.numberOfCards {
            let imageView = setComprobationImages(order: userGuessOrder, i: i)
            userOrderComprobationStack.addArrangedSubview(imageView)
        }
    }

    //Muestra todos los datos de tu última partida.
    func setScoreData() {
        let game: Game = SaveLoad.readGame()
        
        userNameLabel.text = game.userName
        scoreLabel.text = String(game.score)
        gameDurationLabel.text = game.durationOfGame
        gameDateLabel.text = game.dateOfTheGame
    }
    
    //Define qué imágenes se ven en los stackView de comprobación
    func setComprobationImages(order: [Int], i: Int) -> UIImageView{
        let imageView = UIImageView(image: images[order[i]])
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        
        return imageView
    }
}
