import UIKit
import SpriteKit

let settings: Settings = SaveLoad.readSettings()
var images: [UIImage] = GameViewController.images

class ChooseCardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer = Timer()
    
    var cardOrder: [Int] = GameViewController.indices
    var userGuessOrder: [Int] = []
    
    var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        layout.minimumLineSpacing = CGFloat(10.0)
        imagesCollectionView.collectionViewLayout = layout
        
        imagesCollectionView.allowsSelection = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        timerLabel.text = getDurationOfTheGame()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.numberOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = isSelected[indexPath.item] ? "selectedImageCell" : "imageCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCollectionViewCell
        
        cell.collectionViewCellImageView.image = images[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isSelected[indexPath.item] {
            userGuessOrder.append(indexPath.item)
            isSelected.insert(true, at: indexPath.item)
            collectionView.reloadItems(at: [indexPath])
        }
        print(userGuessOrder)
        print("==========")
    }
    
    @IBAction func onAcceptGuessButtonPressed(_ sender: UIButton) {
        
        SaveLoad.saveGame(userName: GameSettingsViewController.userName, score: calculateScore(), durationOfGame: getDurationOfTheGame(), dateOfTheGame: getCurrentShortDate())
        
        performSegue(withIdentifier: "toYourScoreView", sender: nil)
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
        timerLabel.text = getDurationOfTheGame()
    }
    
    func getDurationOfTheGame() -> String {
    
        if seconds < 10 {
            return "0" + String(minutes) + ":0" + String(seconds)
        } else {
            return "0" + String(minutes) + ":" + String(seconds)
        }
    }
    
    func calculateScore() -> Float {
        var score: Float = 0.0
        for i in Range(uncheckedBounds: (0, settings.numberOfCards)) {
            if userGuessOrder[i] == cardOrder[i] {
                score += 1
            }
        }
        return ((score + Float(settings.numberOfCards)) / settings.cardTime) - Float(seconds)
        
    }
    
    func getCurrentShortDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        return dateFormatter.string(from: todaysDate as Date)
    }
}
