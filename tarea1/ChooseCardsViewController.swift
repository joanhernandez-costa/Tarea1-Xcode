import UIKit
import SpriteKit

var userGuessOrder: [Int] = [] //El orden que introduce el usuario pulsando las imágenes.

class ChooseCardsViewController: UIViewController, TimeManagementDelegate {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var userGuessOrderCollectionView: UICollectionView!
    @IBOutlet weak var timeProgressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var imagesCollectionViewManager: CollectionViewManager?
    var userGuessCollectionViewManager: CollectionViewManager?
    
    let timeManager = TimeManagement()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeManager.delegate = self
        
        imagesCollectionViewManager = CollectionViewManager(collectionView: imagesCollectionView,
                                                                                       contentData: cardOrder,
                                                                                       tag: 0,
                                                                                       drawnAt: self)
        
        userGuessCollectionViewManager = CollectionViewManager(collectionView: userGuessOrderCollectionView,
                                                                                          contentData: userGuessOrder,
                                                                                          tag: 1,
                                                                                          drawnAt: self)
        
        imagesCollectionViewManager!.drawCollectionView()
        userGuessCollectionViewManager!.drawCollectionView()
        
        timeManager.timerOn()
        timerLabel.text = "00:00"
        timeProgressView.progress = 0
    }
    
    func timeStep(currentTime: String, progressUntilTimeLimit: Float) {
        
        if progressUntilTimeLimit == 1 || currentTime == "01:00" {
            timeManager.timerOff()
            performSegue(withIdentifier: "toLoseView", sender: nil)
        } else {
            timerLabel.text = currentTime
            timeProgressView.progress = progressUntilTimeLimit
        }
    }
    
    //Se ejecuta cuando se pulsa el botón aceptar. El usuario debe haber seleccionado el mismo número de cartas que aparecen en pantalla.
    @IBAction func onAcceptGuessButtonPressed(_ sender: UIButton) {
        
        if userGuessOrder.count == cardOrder.count {
            timeManager.timerOff()
            
            SaveLoad.saveGame(userName: userName, score: Game.calculateScore(timeProgressView: timeProgressView, userGuessOrder: userGuessOrder, cardOrder: cardOrder), durationOfGame: timeManager.getParsedTimeSinceTimerOn(), dateOfTheGame: Utils.getCurrentShortDate())
            performSegue(withIdentifier: "toYourScoreView", sender: nil)
        } else {
            sender.backgroundColor = .red
        }
    }
}
