//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Xinyi Li on 09/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Add a header to Collection View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        return headerView
    }
    
    // Create a cell every time CollectionView(_:numberOfItemsInSection) is called
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath)
    }
    
    // Only one section to display
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Dislay 20 items in the Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    // Dismiss the location modal when Cancel was hit
    @IBAction func unwindLocationCancel(segue: UIStoryboard) {}

}
