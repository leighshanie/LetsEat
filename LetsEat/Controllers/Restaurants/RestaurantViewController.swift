//
//  RestaurantViewController.swift
//  LetsEat
//
//  Created by Xinyi Li on 10/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet weak var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: Private Extension
private extension RestaurantDetailViewController {
    
}

// MARK: UICollectionViewDataSource
extension RestaurantDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
