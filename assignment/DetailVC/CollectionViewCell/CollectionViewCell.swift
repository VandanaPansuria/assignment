//
//  collectionViewCell.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import Foundation
import UIKit
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    internal func setList(_ contentModel: contentModel) {
        itemName.text = contentModel.name
        img.image = UIImage(named: contentModel.posterImage) != nil ? UIImage(named: contentModel.posterImage) : UIImage(named: "placeholder_for_missing_posters")
    }
}
