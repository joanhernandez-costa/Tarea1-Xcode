import UIKit
import SpriteKit

let settings: Settings = GameSettingsViewController.currentSettings
var images: [UIImage] = GameViewController.images

class ChooseCardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var imagesCollectionView: UICollectionView!
    
    var timer: Timer = Timer()
    
    var cardOrder: [Int] = GameViewController.indices
    var userGuessOrder: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        imagesCollectionView.collectionViewLayout = layout
        
        imagesCollectionView.allowsSelection = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.collectionViewCellImageView.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userGuessOrder.append(indexPath.item)
    }
    
    @IBAction func onAcceptGuessButtonPressed(_ sender: Any) {
        
        SaveLoad.saveGame(userName: GameSettingsViewController.userName, score: calculateScore(), durationOfGame: getDurationOfTheGame(), dateOfTheGame: getCurrentShortDate())
    }
    
    var seconds: Int = 0
    var minutes: Int = 0
    @objc func updateTimer() {
        
        if seconds == 59 {
            seconds = 0
            minutes += 1
        } else {
            seconds += 1
        }
    }
    
    func getDurationOfTheGame() -> Float {
    
        return "0" + String(minutes) + ":" + String(seconds)
    }
    
    func calculateScore() -> Float {
        var score: Float = 0.0
        for i in Range(uncheckedBounds: (0, settings.numberOfCards)) {
            if userGuessOrder[i] == cardOrder[i] {
                score += 1
            }
        }
        return (score + Float(settings.numberOfCards)) / settings.cardTime
    }
    
    func getCurrentShortDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        return dateFormatter.string(from: todaysDate as Date)
    }
}
