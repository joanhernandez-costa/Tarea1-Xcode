import UIKit
import SpriteKit

let settings: Settings = SaveLoad.readSettings()
let userName: String = SaveLoad.readUserName()!
var images: [UIImage] = GameViewController.images

class ChooseCardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer = Timer()
    
    //cardOrder: el orden en el que se han mostrado las cartas en la anterior pantalla.
    //userGuessOrder: el orden que introduce el usuario pulsando las imágenes.
    var cardOrder: [Int] = GameViewController.indices
    var userGuessOrder: [Int] = []
    
    //Lista de booleanos para comprobar si cada elemento de la lista de imágenes ya ha sido seleccionado o no.
    var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    let layout = UICollectionViewFlowLayout()
    let numberOfColumns: CGFloat = 3
    let spacingBetweenCells: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewLayout(layout: layout, numberOfColumns: numberOfColumns, horizontalSpacingBetweenCells: spacingBetweenCells, verticalSpacingBetweenCells: spacingBetweenCells)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        timerLabel.text = getDurationOfTheGame()
    }
    
    //Personaliza los parámetros del CollectionView (espacio entre las celdas, número de columnas...)
    func setCollectionViewLayout(layout: UICollectionViewFlowLayout, numberOfColumns: CGFloat, horizontalSpacingBetweenCells: CGFloat, verticalSpacingBetweenCells: CGFloat) {
        let totalSpacing = (numberOfColumns - 1) * spacingBetweenCells
        
        let width = (imagesCollectionView.bounds.width - totalSpacing) / numberOfColumns
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = horizontalSpacingBetweenCells
        layout.minimumInteritemSpacing = verticalSpacingBetweenCells
        //Se puede diferenciar espacio en vertical y en horizontal. InteritemSpacing espacio entre celdas de la misma fila, LineSpacing espcio entre celdas en la misma columna.
        
        imagesCollectionView.collectionViewLayout = layout
        imagesCollectionView.allowsSelection = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.numberOfCards
    }
    
    //Se ejecuta cada vez que se quiere "dibujar" una celda. Diferencia si la imagen ha sido seleccionada y en base a eso usa una celda prototipo u otra.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = isSelected[indexPath.item] ? "selectedImageCell" : "imageCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCollectionViewCell
        
        cell.CellImageView.image = images[indexPath.item]
        
        return cell
    }
    
    //Se ejecuta cada vez que el usuario pulsa sobre una imagen. Se añade el índice de esa imagen a la lista userGuessOrder si no ha sido seleccionada todavía.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isSelected[indexPath.item] {
            userGuessOrder.append(indexPath.item)
            //Insertar en la lista isSelected en el índice de la imagen seleccionada un valor "true" (Se ha seleccionado la imagen). Y refrescar vista.
            isSelected[indexPath.item] = true
            collectionView.reloadItems(at: [indexPath])
        }
        print(userGuessOrder)
        print("------------")
        print(cardOrder)
        print("============")

    }
    
    //Se ejecuta cuando se pulsa el botón aceptar. El usuario debe haber seleccionado el mismo número de cartas que aparecen en pantalla.
    @IBAction func onAcceptGuessButtonPressed(_ sender: UIButton) {
        
        if userGuessOrder.count == cardOrder.count {
            SaveLoad.saveGame(userName: userName, score: calculateScore(), durationOfGame: getDurationOfTheGame(), dateOfTheGame: getCurrentShortDate())
            performSegue(withIdentifier: "toYourScoreView", sender: nil)
        } else {
            sender.backgroundColor = .red
        }
    }
    
    //Actualiza el Label del temporizador cada segundo.
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
    
    //Parsea y devuelve un String con el tiempo que ha tardado el usuario en completar el juego para mostrar la puntuación en la siguiente pantalla.
    func getDurationOfTheGame() -> String {
    
        if seconds < 10 {
            return "0" + String(minutes) + ":0" + String(seconds)
        } else {
            return "0" + String(minutes) + ":" + String(seconds)
        }
    }
    
    //Función para calcular puntuación.
    func calculateScore() -> Float {
        //MODIFICAR FUNCIÓN. EL TIEMPO QUE HAS TARDADO DEBE INFLUIR.
        var score: Float = 0.0
        let maxScorePossible = Float(12 + 12) / 0.3
        for i in Range(uncheckedBounds: (0, settings.numberOfCards)) {
            if userGuessOrder[i] == cardOrder[i] {
                score += 1.0
            }
        }
        let finalScore = score + Float(settings.numberOfCards) / settings.cardTime
        return (finalScore / maxScorePossible) * 10
    }
    
    //Devuelve String parseado de la fecha actual.
    func getCurrentShortDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        return dateFormatter.string(from: todaysDate as Date)
    }
}
