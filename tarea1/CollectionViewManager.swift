
import Foundation
import UIKit

class CollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView
    var contentData: [Int]
    var tag: Int
    var delegate: CollectionViewManagerDelegate
    
    init(collectionView: UICollectionView, contentData: [Int], tag: Int, drawnAt: UIViewController, delegate: CollectionViewManagerDelegate) {
        self.collectionView = collectionView
        self.contentData = contentData
        self.tag = tag
        self.delegate = delegate
    }
    
    //Configura el CollectionView:
    func drawCollectionView() {
        collectionViewSetUp()
        let layout = setLayoutConfigurator().configureLayout(for: collectionView)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.collectionViewLayout = layout
        
        collectionView.reloadData()
    }
    
    //Devuelve un layout con los parámetros elegidos.
    func setLayoutConfigurator() -> CollectionViewLayoutConfigurator {
        if tag == 0 {
            collectionView.backgroundColor = .blue
            return CollectionViewLayoutConfigurator(numberOfColumns: 3, horizontalSpacingBetweenCells: 10, verticalSpacingBetweenCells: 10)
        } else {
            collectionView.backgroundColor = .cyan
            return CollectionViewLayoutConfigurator(numberOfColumns: CGFloat(contentData.count), horizontalSpacingBetweenCells: 5, verticalSpacingBetweenCells: 5)
        }
    }
    
    //Configura dataSource y Delegate
    func collectionViewSetUp() {
        
        collectionView.tag = tag
        collectionView.allowsSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentData.count
    }
    
    //Lista de booleanos para comprobar si cada elemento de la lista de imágenes ya ha sido seleccionado o no.
    var isSelected: [Bool] = Array(repeating: false, count: currentSettings.numberOfCards)
    
    //Se ejecuta cada vez que se quiere "dibujar" una celda. Diferencia si la imagen ha sido seleccionada y en base a eso usa una celda prototipo u otra.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellID = ""
        var cell = ImageCollectionViewCell()
        switch collectionView.tag {
        case 0:
            cellID = isSelected[indexPath.item] ? "selectedImageCell" : "imageCell"
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCollectionViewCell
            cell.imageCellImageView.image = images[indexPath.item]
        case 1:
            cellID = "imageCell"
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCollectionViewCell
            cell.userGuessCellImageView.image = images[contentData[indexPath.item]]
        default:
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    //Se ejecuta cada vez que el usuario pulsa sobre una imagen.
    //Si se pulsa sobre el imagesCollectionView, se añade el índice de esa imagen a la lista userGuessOrder si no ha sido seleccionada antes y se actualiza el userGuessCollectionView. Si se pulsa sobre el userGuessCollectionView, se "deselecciona" la imagen y se actualiza imagesCollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            if !isSelected[indexPath.item] {
                isSelected[indexPath.item] = true
            }
            delegate.collectionViewUpdated(collectionView: collectionView, indexPath: indexPath)
        case 1:
            isSelected[indexPath.item] = false
            delegate.collectionViewUpdated(collectionView: collectionView, indexPath: indexPath)
        default:
            return
        }
    }
}
