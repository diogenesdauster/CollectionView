//
//  ViewController.swift
//  CollectionView
//
//  Created by Diógenes Dauster on 8/31/19.
//  Copyright © 2019 Dauster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var collectionView: UICollectionView!

    let collectionData = ["1 👻","2 🐯","3 🦉","4 🎅🏻","5 🐀","6 🎊","7 🌽","8 🎂","9 🍂","10 🎭","11 🎉","12 ☁️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // know the size of the screen
        let width = (view.frame.width - 20) / 3
        
        // pick the layout up and casted to FlowLayout because the ViewLayout doesn't have the witdh property
        let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // set the size up in the layout
        collectionLayout.itemSize = CGSize(width: width, height: width)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailViewController,
                let indexPath = sender as? IndexPath {
                destination.textDescription = collectionData[indexPath.row]
            }

        }

    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = collectionData[indexPath.row]
        }
        
        return cell
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let text = collectionData[indexPath.row]
        
        performSegue(withIdentifier: "DetailSegue", sender: indexPath )
        
        print("Selected \(text)")
        
    }
    

    
    
}
