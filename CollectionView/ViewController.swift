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
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    var collectionData = ["1 👻","2 🐯","3 🦉","4 🎅🏻","5 🐀","6 🎊","7 🌽","8 🎂","9 🍂","10 🎭","11 🎉","12 ☁️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // know the size of the screen
        let width = (view.frame.width - 20) / 3
        
        // pick the layout up and casted to FlowLayout because the ViewLayout doesn't have the witdh property
        let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // set the size up in the layout
        collectionLayout.itemSize = CGSize(width: width, height: width)
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.resfresh), for: .valueChanged)
        collectionView.refreshControl = refresh
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    @IBAction func addItem() {
        
        collectionView.performBatchUpdates ({
            for _ in 0...1 {
                let newItem = "\(collectionData.count + 1) 🌸"
                collectionData.append(newItem)
                let indexPath = IndexPath(row: collectionData.count - 1, section: 0)
                collectionView.insertItems(at: [indexPath])
            }
        })
        
    }
    
    @IBAction func deleteItems(){
        
        collectionView.performBatchUpdates({
            if let selectedItems = collectionView.indexPathsForSelectedItems?.sorted(by: {$0.row > $1.row }) {
//                var count = 0
                for indexPath in selectedItems {
//                    let row = indexPath.row - count
//                    count += 1
                    collectionData.remove(at: indexPath.row)
                }
                collectionView.deleteItems(at: selectedItems)
            }
        }, completion: nil)
        
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.isEnabled = !editing
        trashButton.isEnabled = editing
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isEditing = editing
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailViewController,
                let indexPath = sender as? IndexPath {
                destination.textDescription = collectionData[indexPath.row]
            }
            
        }
        
    }
    
    @objc func resfresh() {
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.labelTitle.text = collectionData[indexPath.row]
        cell.isEditing = isEditing
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let text = collectionData[indexPath.row]
        
        if !isEditing {
            performSegue(withIdentifier: "DetailSegue", sender: indexPath )
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.isSelected = false
        }
        
        print("Selected \(text)")
        
    }
    
    
    
    
}
