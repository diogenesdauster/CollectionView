//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Diógenes Dauster on 9/1/19.
//  Copyright © 2019 Dauster. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var textDescription: String?
    @IBOutlet private weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelDescription.text = textDescription
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
