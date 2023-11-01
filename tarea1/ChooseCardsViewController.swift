import UIKit
import SpriteKit

let settings: Settings = SaveLoad.readSettings()
let userName: String = SaveLoad.readUserName()!
let images: [UIImage] = GameViewController.images
let cardOrder: [Int] = GameViewController.indices
var userGuessOrder: [Int] = []
//cardOrder: el orden en el que se han mostrado las cartas en la anterior pantalla.
//userGuessOrder: el orden que introduce el usuario pulsando las imágenes.

class ChooseCardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var userGuessOrderCollectionView: UICollectionView!
    @IBOutlet var timeProgressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer = Timer()
    
    //Lista de booleanos para comprobar si cada elemento de la lista de imágenes ya ha sido seleccionado o no.
    var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    let numberOfColumns: CGFloat = 3
    let spacingBetweenCells: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewLayout(numberOfColumns: numberOfColumns, horizontalSpacingBetweenCells: spacingBetweenCells, verticalSpacingBetweenCells: spacingBetweenCells)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        timerLabel.text = getDurationOfTheGame()
        timeProgressView.progress = 0
    }
    
    //Personaliza los parámetros del CollectionView (espacio entre las celdas, número de columnas...)
    func setCollectionViewLayout(numberOfColumns: CGFloat, horizontalSpacingBetweenCells: CGFloat, verticalSpacingBetweenCells: CGFloat) {
        
        let imagesLayout = UICollectionViewFlowLayout()
        let totalSpacing = (numberOfColumns - 1) * spacingBetweenCells
    
        let width = (imagesCollectionView.bounds.width - totalSpacing) / numberOfColumns
        imagesLayout.itemSize = CGSize(width: width, height: width)
        imagesLayout.minimumLineSpacing = horizontalSpacingBetweenCells
        imagesLayout.minimumInteritemSpacing = verticalSpacingBetweenCells
        //Se puede diferenciar espacio en vertical y en horizontal. InteritemSpacing espacio entre filas, LineSpacing espcio entre columnas.
        
        imagesCollectionView.tag = 0
        imagesCollectionView.collectionViewLayout = imagesLayout
        imagesCollectionView.allowsSelection = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        userGuessOrderCollectionView.tag = 1
        userGuessOrderCollectionView.allowsSelection = true
        userGuessOrderCollectionView.dataSource = self
        userGuessOrderCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? settings.numberOfCards : userGuessOrder.count
    }
    
    //Se ejecuta cada vez que se quiere "dibujar" una celda. Diferencia si la imagen ha sido seleccionada y en base a eso usa una celda prototipo u otra.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cellID = isSelected[indexPath.item] ? "selectedImageCell" : "imageCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCollectionViewCell
            
            cell.CellImageView.image = images[indexPath.item]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            
            cell.CellImageView.image = images[userGuessOrder[indexPath.item]]
            
            return cell
        }
    }
    
    //Se ejecuta cada vez que el usuario pulsa sobre una imagen. Se añade el índice de esa imagen a la lista userGuessOrder si no ha sido seleccionada todavía.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            if !isSelected[indexPath.item] {
                userGuessOrder.append(indexPath.item)
                //Insertar en la lista isSelected en el índice de la imagen seleccionada un valor "true" (Se ha seleccionado la imagen). Y refrescar vista.
                isSelected[indexPath.item] = true
                collectionView.reloadItems(at: [indexPath])
            }
        } else {
            userGuessOrder.remove(at: indexPath.item)
            isSelected[indexPath.item] = false
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    //Se ejecuta cuando se pulsa el botón aceptar. El usuario debe haber seleccionado el mismo número de cartas que aparecen en pantalla.
    @IBAction func onAcceptGuessButtonPressed(_ sender: UIButton) {
        
        if userGuessOrder.count == cardOrder.count {
            SaveLoad.saveGame(userName: userName, score: Game.calculateScore(timeProgressView: timeProgressView, userGuessOrder: userGuessOrder, cardOrder: cardOrder), durationOfGame: getDurationOfTheGame(), dateOfTheGame: getCurrentShortDate())
            performSegue(withIdentifier: "toYourScoreView", sender: nil)
        } else {
            sender.backgroundColor = .red
        }
    }
    
    //Actualiza el Label del temporizador cada segundo y gestiona el progreso del ProgressView.
    var seconds: Int = 0
    var minutes: Int = 0
    @objc func updateTimer() {
        
        if timeProgressView.progress == 1 {
            performSegue(withIdentifier: "toLoseView", sender: nil)
        } else {
            timeProgressView.progress = Float(seconds) / Float(settings.timeLimit)
        }
        
        if seconds == 59 {
            seconds = 0
            minutes += 1
        } else {
            seconds += 1
        }
        timerLabel.text = getDurationOfTheGame()
    }
    
    //Parsea y devuelve un String con el tiempo que ha tardado el usuario en completar el juego para mostrar la puntuación en la siguiente pantalla.
    func getDurationOfTheGame() -> String {
    
        if seconds < 10 {
            return "0" + String(minutes) + ":0" + String(seconds)
        } else {
            return "0" + String(minutes) + ":" + String(seconds)
        }
    }
    
    //Devuelve String parseado de la fecha actual.
    func getCurrentShortDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        return dateFormatter.string(from: todaysDate as Date)
    }
}
