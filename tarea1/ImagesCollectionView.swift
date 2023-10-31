
import Foundation
import UIKit
import SpriteKit

class ImagesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false]
    
    let layout = UICollectionViewFlowLayout()
    let numberOfColumns: CGFloat = 3
    let spacingBetweenCells: CGFloat = 10
    
    //Personaliza los parámetros del CollectionView (espacio entre las celdas, número de columnas...)
    func setCollectionViewLayout(imagesCollectionView: UICollectionView) {
        let totalSpacing = (numberOfColumns - 1) * spacingBetweenCells
        
        let width = (imagesCollectionView.bounds.width - totalSpacing) / numberOfColumns
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = spacingBetweenCells
        layout.minimumInteritemSpacing = spacingBetweenCells
        //Se puede diferenciar espacio en vertical y en horizontal. InteritemSpacing espacio entre filas, LineSpacing espcio entre columnas.
        
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
            ChooseCardsViewController.userGuessOrder.append(indexPath.item)
            //Insertar en la lista isSelected en el índice de la imagen seleccionada un valor "true" (Se ha seleccionado la imagen). Y refrescar vista.
            isSelected[indexPath.item] = true
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
}
