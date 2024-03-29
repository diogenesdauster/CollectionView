//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Diógenes Dauster on 9/1/19.
//  Copyright © 2019 Dauster. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var park: Park?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Display Park info
        if let park = park {
            navigationItem.title = park.name
            imageView.image = UIImage(named: park.photo)
            nameLabel.text = park.name
            stateLabel.text = park.state
            dateLabel.text = park.date
        }
    }
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

}
