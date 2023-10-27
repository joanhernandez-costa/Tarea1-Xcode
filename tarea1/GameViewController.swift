import UIKit

class GameViewController: UIViewController {
    
    static let images: [UIImage] = [UIImage(named: "avestruz")!,
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
    
    static var indices: [Int] = []
    
    @IBOutlet weak var showCardsImageView: UIImageView!
    
    var timer: Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameSettings: Settings = SaveLoad.readSettings()
        
        for i in Range(uncheckedBounds: (0, gameSettings.numberOfCards)) {
            GameViewController.indices.append(i)
        }
        GameViewController.indices.shuffle()
        
        timer = Timer.scheduledTimer(timeInterval: Double(gameSettings.cardTime), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    var i: Int = 0
    @objc func fireTimer() {
        
        if i == GameViewController.indices.count {
            timer.invalidate()
            performSegue(withIdentifier: "toChooseCardsView", sender: nil)
        } else {
            showCardsImageView.image = GameViewController.images[GameViewController.indices[i]]
            i += 1
        }
    }
    
}
