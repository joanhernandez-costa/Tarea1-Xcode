
import Foundation
import UIKit

protocol CollectionViewManagerDelegate: AnyObject {
    func collectionViewUpdated(collectionView: UICollectionView, indexPath: IndexPath)
}
