import UIKit

class GameViewController: UIViewController {
    
    //Array de imágenes con las que trabajar.
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
    
    //Almacena los índices de las imágenes que se van a mostrar en el juego.
    static var indices: [Int] = []
    
    @IBOutlet weak var showCardsImageView: UIImageView!
    
    var timer: Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cargar Settings seleccinados en Settings View.
        let gameSettings: Settings = SaveLoad.readSettings()
        
        //Introducir en la lsita de índices solo valores entre 0 y número de cartas. Después se "baraja" la lista para mostrar orden aleatorio.
        for i in Range(uncheckedBounds: (0, gameSettings.numberOfCards)) {
            GameViewController.indices.append(i)
        }
        GameViewController.indices.shuffle()
        
        timer = Timer.scheduledTimer(timeInterval: Double(gameSettings.cardTime), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    //Recorrer el array de imágenes mostrando cada tiempo de carta las imágenes que corresponden a la lista de índices.
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
