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
    
    var indices: [Int] = []
    
    @IBOutlet weak var showCardsImageView: UIImageView!
    let gameSettings: GameSettingsViewController = GameSettingsViewController()
    
    var numberOfCards: Int = 0
    var cardTime: Float = 0.0
    
    var timer: Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfCards = gameSettings.currentSettings.numberOfCards
        cardTime = gameSettings.currentSettings.cardTime
        
        for i in Range(uncheckedBounds: (0, numberOfCards)) {
            indices.append(i)
        }
        indices = indices.shuffled()
        
        timer = Timer.scheduledTimer(timeInterval: Double(cardTime), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    var i: Int = 0
    @objc func fireTimer() {

        if i == indices.count {
            timer.invalidate()
            performSegue(withIdentifier: "toChooseCardsView", sender: nil)
        } else {
            showCardsImageView.image = images[indices[i]]
            i += 1
        }
    }
}
