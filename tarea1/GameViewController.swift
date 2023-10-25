import UIKit

class GameViewController: UIViewController {
    
    let images: [UIImage] = [UIImage(named: "avestruz")!,
                            UIImage(named: "gato")!,
                            UIImage(named: "leon")!,
                            UIImage(named: "lobo")!,
                            UIImage(named: "loro")!,
                            UIImage(named: "mono")!,
                            UIImage(named: "perro")!,
                            UIImage(named: "pez")!,
                            UIImage(named: "rinoceronte")!,
                            UIImage(named: "tigre")!,
                            UIImage(named: "aguila")!,
                            UIImage(named: "tortuga")!]
    
    
    
    @IBOutlet weak var showCardsImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameSettings: GameSettingsViewController = GameSettingsViewController()
        
        let userName: String = gameSettings.userName
        
        let numberOfCards: Int = gameSettings.currentSettings.numberOfCards
        let cardTime: Float = gameSettings.currentSettings.cardTime
    }
    
    func showCardsGame() {
        
    }
    
    func userChosesCardsGame() {
        
    }

}
