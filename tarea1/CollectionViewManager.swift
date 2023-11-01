
import Foundation
import UIKit

class CollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView
    var contentData: [Int]
    var tag: Int
    var drawnAt: UIViewController
    var numberOfColumns: CGFloat
    var numberOfRows: CGFloat
    var horizontalSpacingBetweenCells: CGFloat
    var verticalSpacingBetweenCells: CGFloat
    
    init(collectionView: UICollectionView, contentData: [Int], tag: Int, drawnAt: UIViewController, numberOfColumns: CGFloat, numberOfRows: CGFloat, horizontalSpacingBetweenCells: CGFloat, verticalSpacingBetweenCells: CGFloat) {
        self.collectionView = collectionView
        self.contentData = contentData
        self.tag = tag
        self.drawnAt = drawnAt
        self.numberOfColumns = numberOfColumns
        self.numberOfRows = numberOfRows
        self.horizontalSpacingBetweenCells = horizontalSpacingBetweenCells
        self.verticalSpacingBetweenCells = verticalSpacingBetweenCells
    }
    
    func drawCollectionView() {
        
        if rowsAndColumnsAreValid() {
            collectionViewSetUp()
        } else {
            print("Error al dibujar CollectionView")
        }
    }
    
    func rowsAndColumnsAreValid() -> Bool {
        return numberOfRows * numberOfColumns <= CGFloat(contentData.count) && numberOfRows * numberOfColumns >= CGFloat(contentData.count) - (numberOfColumns - 1)
    }
    
    func collectionViewSetUp() {
        
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
        collectionView.collectionViewLayout = layout
        
        collectionView.tag = tag
        collectionView.allowsSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.numberOfCards
    }
    
    var isSelected: [Bool] = Array(repeating: false, count: settings.numberOfCards)
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellID = ""
        switch collectionView.tag {
        case 0:
            cellID = isSelected[indexPath.item] ? "selectedImageCell" : "imageCell"
            collectionView.backgroundColor = .blue
        case 1:
            cellID = "imageCell"
            collectionView.backgroundColor = .cyan
        default:
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCollectionViewCell
        cell.CellImageView.image = images[contentData[indexPath.item]]
        return cell
    }
    
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
            isSelected[indexPath.item] = false
            collectionView.deleteItems(at: [indexPath])
        default:
            return
        }
    }
}
