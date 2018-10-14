//
//  PhotoCell.swift
//  LetsEat
//
//  Created by Xinyi Li on 14/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imgReview: UIImageView!
}

extension PhotoCell {
    func set(image: UIImage) {
        imgReview.image = image
        roundedCorners()
    }
    
    func roundedCorners() {
        imgReview.layer.cornerRadius = 9
        imgReview.layer.masksToBounds = true
    }
}
