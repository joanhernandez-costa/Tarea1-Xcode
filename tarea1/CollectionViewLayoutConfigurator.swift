
import Foundation
import UIKit

class CollectionViewLayoutConfigurator {
    var numberOfColumns: CGFloat
    var numberOfRows: CGFloat
    var horizontalSpacingBetweenCells: CGFloat
    var verticalSpacingBetweenCells: CGFloat

    init(numberOfColumns: CGFloat, horizontalSpacingBetweenCells: CGFloat, verticalSpacingBetweenCells: CGFloat) {
        self.numberOfColumns = numberOfColumns
        self.numberOfRows = ceil(CGFloat(currentSettings.numberOfCards) / numberOfColumns)
        self.horizontalSpacingBetweenCells = horizontalSpacingBetweenCells
        self.verticalSpacingBetweenCells = verticalSpacingBetweenCells
    }
    
    //Introduce todos los parámetros elegidos en el layout y lo devuelve.
    func configureLayout(for collectionView: UICollectionView) -> UICollectionViewFlowLayout {
        switch collectionView.tag {
        case 0:
            let layout = UICollectionViewFlowLayout()
            
            let totalHorizontalSpacing = (numberOfColumns - 1) * horizontalSpacingBetweenCells
            let totalVerticalSpacing = (numberOfRows - 1) * verticalSpacingBetweenCells
                
            let cellWidth = (collectionView.bounds.width - totalHorizontalSpacing) / numberOfColumns
            let cellHeight = (collectionView.bounds.height - totalVerticalSpacing) / numberOfRows
                
            //collectionView.bounds.height = totalVerticalSpacing + (numberOfRows * cellHeight)
            //collectionView.constraints[0].
                
            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            layout.minimumLineSpacing = horizontalSpacingBetweenCells
            layout.minimumInteritemSpacing = verticalSpacingBetweenCells
            //Se puede diferenciar espacio en vertical y en horizontal. InteritemSpacing espacio entre filas, LineSpacing espcio entre columnas.
                
            return layout
        case 1:
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            let paddingSpace = layout.sectionInset.left + layout.sectionInset.right
            let availableWidth = collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / CGFloat(currentSettings.numberOfCards)
            layout.itemSize = CGSize(width: widthPerItem, height: 40)

            return layout
        default:
            return UICollectionViewFlowLayout()
        }
        
    }
}
