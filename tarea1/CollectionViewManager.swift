
import Foundation
import UIKit

class CollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView
    var contentData: [Int]
    var tag: Int
    var drawnAt: UIViewController
    
    init(collectionView: UICollectionView, contentData: [Int], tag: Int, drawnAt: UIViewController) {
        self.collectionView = collectionView
        self.contentData = contentData
        self.tag = tag
        self.drawnAt = drawnAt
    }
    
    func drawCollectionView() {
        collectionViewSetUp()
        let layout = setLayoutConfigurator().configureLayout(for: collectionView)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.collectionViewLayout = layout
        
        collectionView.reloadData()
    }
    
    func setLayoutConfigurator() -> CollectionViewLayoutConfigurator {
        if tag == 0 {
            collectionView.backgroundColor = .blue
            return CollectionViewLayoutConfigurator(numberOfColumns: 3, horizontalSpacingBetweenCells: 10, verticalSpacingBetweenCells: 10)
        } else {
            collectionView.backgroundColor = .cyan
            return CollectionViewLayoutConfigurator(numberOfColumns: CGFloat(contentData.count), horizontalSpacingBetweenCells: 5, verticalSpacingBetweenCells: 5)
        }
    }
    
    //Personaliza los parámetros del CollectionView (espacio entre las celdas, número de columnas...)
    func collectionViewSetUp() {
        
        collectionView.tag = tag
        collectionView.allowsSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self

        print("Configuring collectionView with tag \(collectionView.tag)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentData.count
    }
    
    //Lista de booleanos para comprobar si cada elemento de la lista de imágenes ya ha sido seleccionado o no.
    var isSelected: [Bool] = Array(repeating: false, count: currentSettings.numberOfCards)
    
    //Se ejecuta cada vez que se quiere "dibujar" una celda. Diferencia si la imagen ha sido seleccionada y en base a eso usa una celda prototipo u otra.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellID = ""
        switch collectionView.tag {
        case 0:
            cellID = isSelected[indexPath.item] ? "selectedImageCell" : "imageCell"
        case 1:
            cellID = "imageCell"
        default:
            return UICollectionViewCell()
        }
                    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCollectionViewCell
        cell.CellImageView.image = images[contentData[indexPath.item]]
        return cell
    }
    
    //Se ejecuta cada vez que el usuario pulsa sobre una imagen.
    //Si se pulsa sobre el imagesCollectionView, se añade el índice de esa imagen a la lista userGuessOrder si no ha sido seleccionada antes y se actualiza el userGuessCollectionView. Si se pulsa sobre el userGuessCollectionView, se "deselecciona" la imagen y se actualiza imagesCollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            if !isSelected[indexPath.item] {
                isSelected[indexPath.item] = true
                userGuessOrder.append(indexPath.item)
                if let otherCollectionView = drawnAt.view.viewWithTag(1) as? UICollectionView {
                    otherCollectionView.reloadData()
                }
                collectionView.reloadItems(at: [indexPath])
            }
        case 1:
            contentData.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
            isSelected[indexPath.item] = false
            if let otherCollectionView = drawnAt.view.viewWithTag(0) as? UICollectionView {
                otherCollectionView.reloadData()
            }
        default:
            return
        }
    }
}
