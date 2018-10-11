//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Xinyi Li on 09/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var collectionView:UICollectionView!
    let manager = ExploreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // Dismiss the location modal when Cancel was hit
    @IBAction func unwindLocationCancel(segue: UIStoryboard) {}

}

// MARK: Private Extention
private extension ExploreViewController {
    func initialize() {
        manager.fetch()
    }
}

// MARK: UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {
    
    // Add a header to Collection View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        return headerView
    }
    
    // Create a cell every time CollectionView(_:numberOfItemsInSection) is called
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        let item = manager.explore(at: indexPath)
        if let name = item.name { cell.lblName.text = name }
        if let image = item.image { cell.imgExplore.image = UIImage(named: image) }
        return cell
    }
    
    // Only one section to display
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Dislay 20 items in the Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
}
