import UIKit

//Array de imágenes con las que trabajar.
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

//Almacena los índices de las imágenes que se van a mostrar en el juego.
var cardOrder: [Int] = []

class ShowCardsViewController: UIViewController, TimeManagementDelegate {
    
    @IBOutlet weak var showCardsImageView: UIImageView!
    
    //Gestión del tiempo, empezar a contar el tiempo, parar, contar cada x segundos.
    let timeManager = TimeManagement()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cargar Settings seleccinados en Settings View.
        let gameSettings: Settings = SaveLoad.readSettings()
        
        //Introducir en la lsita de índices solo valores entre 0 y número de cartas. Después se "baraja" la lista para mostrar orden aleatorio.
        for i in Range(uncheckedBounds: (0, gameSettings.numberOfCards)) {
            cardOrder.append(i)
        }
        cardOrder.shuffle()
        
        print(cardOrder)
        
        timeManager.delegate = self
        timeManager.timerOn()
    }

    //Recorrer el array de imágenes mostrando cada tiempo de carta las imágenes que corresponden a la lista de índices. Se ejecuta cada cardTime segundos.
    var i: Int = 0
    func timeStep(currentTime: String, progressUntilTimeLimit: Float) {
        if i == cardOrder.count {
            timeManager.timerOff()
            performSegue(withIdentifier: "toChooseCardsView", sender: nil)
        } else {
            showCardsImageView.image = images[cardOrder[i]]
            i += 1
        }
    }
}
