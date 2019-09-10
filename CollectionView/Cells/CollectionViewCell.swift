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
    @IBOutlet private weak var imageCell: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var isEditing: Bool = false {
        didSet {
            checkImage.isHidden = !isEditing
        }
    }
    
    var park: Park? {
        didSet {
            imageCell.image = UIImage(named: park!.photo )
            labelTitle.text = park?.name
        }
    }
    
    override func prepareForReuse() {
        imageCell.image = nil
    }
    
    override var isSelected: Bool {
        didSet {
            checkImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
        }
    }
    

    
}
