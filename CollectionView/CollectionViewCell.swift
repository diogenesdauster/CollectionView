//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Diógenes Dauster on 9/2/19.
//  Copyright © 2019 Dauster. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet  weak var labelTitle: UILabel!
    @IBOutlet  weak var checkImage: UIImageView!
    
    var isEditing: Bool = false {
        didSet {
            checkImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            checkImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
        }
    }
    
}
