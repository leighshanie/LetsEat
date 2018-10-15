//
//  ExploreCell.swift
//  LetsEat
//
//  Created by Xinyi Li on 10/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    @IBOutlet var lblName:UILabel!
    @IBOutlet var imgExplore:UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedCorners()
    }
}

private extension ExploreCell {
    func roundedCorners() {
        imgExplore.layer.cornerRadius = 9
        imgExplore.layer.masksToBounds = true
    }
}
