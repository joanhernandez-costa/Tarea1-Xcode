import UIKit
import SpriteKit

var userGuessOrder: [Int] = [] //El orden que introduce el usuario pulsando las imágenes.

class ChooseCardsViewController: UIViewController, TimeManagementDelegate, CollectionViewManagerDelegate {
    
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
        imagesCollectionViewManager?.delegate = self
        userGuessCollectionViewManager?.delegate = self
        
        imagesCollectionViewManager = CollectionViewManager(collectionView: imagesCollectionView,
                                                                                       contentData: cardOrder,
                                                                                       tag: 0,
                                                                                       drawnAt: self,
                                                                                       delegate: self)
        
        userGuessCollectionViewManager = CollectionViewManager(collectionView: userGuessOrderCollectionView,
                                                                                          contentData: userGuessOrder,
                                                                                          tag: 1,
                                                                                          drawnAt: self,
                                                                                          delegate: self)
        
        imagesCollectionViewManager!.drawCollectionView()
        userGuessCollectionViewManager!.drawCollectionView()
        
        timeManager.timerOn()
        timerLabel.text = "00:00"
        timeProgressView.progress = 0
    }
    
    func timeStep(currentTime: String, progressUntilTimeLimit: Float) {
        
        if progressUntilTimeLimit == 1 || currentTime == "01:00" {
            timeManager.timerOff()
            //performSegue(withIdentifier: "toLoseView", sender: nil)
        } else {
            timerLabel.text = currentTime
            timeProgressView.progress = progressUntilTimeLimit
        }
    }
    
    func collectionViewUpdated(collectionView: UICollectionView, indexPath: IndexPath) {
        if collectionView.tag == 0 {
            userGuessCollectionViewManager?.contentData.append(images.firstIndex(of: images[indexPath.item])!)
            userGuessOrderCollectionView.reloadData()
            imagesCollectionView.reloadItems(at: [indexPath])
            
            print(userGuessCollectionViewManager!.contentData)
        } else {
            userGuessCollectionViewManager?.contentData.remove(at: indexPath.item)
            userGuessOrderCollectionView.deleteItems(at: [indexPath])
            imagesCollectionView.reloadItems(at: [indexPath])
            
            print(userGuessCollectionViewManager!.contentData)
        }
        userGuessOrder = userGuessCollectionViewManager!.contentData
    }
    
    //Se ejecuta cuando se pulsa el botón aceptar. El usuario debe haber seleccionado el mismo número de cartas que aparecen en pantalla.
    @IBAction func onAcceptGuessButtonPressed(_ sender: UIButton) {
        
        if userGuessOrder.count == cardOrder.count {
            timeManager.timerOff()
            
            let game = Game(userName: userName,
                            score: Game.calculateScore(timeProgressView: timeProgressView,
                                                       userGuessOrder: userGuessCollectionViewManager!.contentData,
                                                       cardOrder: cardOrder),
                            durationOfGame: timeManager.getParsedTimeSinceTimerOn(),
                            dateOfTheGame: Utils.getCurrentShortDate())
            
            ApiCalls().postGame(game: GameData(name: "game", data: game))
            SaveLoad.saveGame(game: game)
            
            performSegue(withIdentifier: "toYourScoreView", sender: nil)
        } else {
            sender.backgroundColor = .red
        }
    }
}
