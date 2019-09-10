//
//  ViewController.swift
//  CollectionView
//
//  Created by Diógenes Dauster on 8/31/19.
//  Copyright © 2019 Dauster. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    private let dataSource = DataSource()
    
    var collectionData = ["1 👻","2 🐯","3 🦉","4 🎅🏻","5 🐀","6 🎊","7 🌽","8 🎂","9 🍂","10 🎭","11 🎉","12 ☁️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // know the size of the screen
        let width = (view.frame.width) / 3
        
        // pick the layout up and casted to FlowLayout because the ViewLayout doesn't have the witdh property
        let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // set the size up in the layout
        collectionLayout.itemSize = CGSize(width: width, height: width)
        
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.resfresh), for: .valueChanged)
        collectionView.refreshControl = refresh
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.title = "National Parks"
        
        navigationController?.isToolbarHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailViewController{
                destination.park =  sender as? Park
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.isEnabled = !editing
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForSelectedItems?.forEach {
            collectionView.deselectItem(at: $0, animated: false)
        }
        
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isEditing = editing
        }
        
        
        if !editing {
            navigationController?.isToolbarHidden = true
        }
    }
    
    @IBAction func addItem() {
        
        let index = dataSource.newRandomPark()
        collectionView?.insertItems(at: [index])
        
    }
    
    
    @objc func resfresh() {
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    
    @IBAction func deleteItems(){
        
        collectionView.performBatchUpdates({
            if let selected = collectionView.indexPathsForSelectedItems {
                dataSource.deleteItemsAtIndexPaths(selected)
                collectionView.deleteItems(at: selected)
                navigationController?.isToolbarHidden = true

            }
        }, completion: nil )
        
        self.setEditing(false, animated: true)
        
    }
    
    
}

extension ViewController  {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if let park = dataSource.parkForItemAtIndexPath(indexPath) {
            cell.park = park
            cell.isEditing = isEditing
        }
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        if !isEditing {
            let park = dataSource.parkForItemAtIndexPath(indexPath)
            performSegue(withIdentifier: "DetailSegue", sender: park )
        } else {
            navigationController?.isToolbarHidden = false
        }
        
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems,
                selected.count == 0 {
                navigationController?.isToolbarHidden = true
            }
        }
    }
    
    
    
}
