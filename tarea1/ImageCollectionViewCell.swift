//
//  ImageCollectionViewCell.swift
//  tarea1
//
//  Created by user197292 on 10/26/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionViewCellImageView: UIImageView!
    static let identifier: String = "imageCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "imageCellNib", bundle: nil)
    }
}
