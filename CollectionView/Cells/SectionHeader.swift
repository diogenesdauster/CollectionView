//
//  SectionHeader.swift
//  CollectionView
//
//  Created by Diógenes Dauster on 9/11/19.
//  Copyright © 2019 Dauster. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var textCount: UILabel!
    @IBOutlet private weak var flag: UIImageView!
    
    
    var section: Section! {
        didSet {
                textLabel.text = section.name
                textCount.text = "\(section.count)"
                flag.image = UIImage(named: section.name ?? "")
        }
    }
}
