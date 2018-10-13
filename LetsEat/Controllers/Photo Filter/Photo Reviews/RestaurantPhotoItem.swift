//
//  RestaurantPhotoItem.swift
//  LetsEat
//
//  Created by Xinyi Li on 14/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

struct RestaurantPhotoItem {
    var photo: UIImage?
    var date: NSDate?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    var photoData: NSData {
        guard let image = photo else {
            return NSData()
        }
        return NSData(data: image.pngData()!)
    }
}

extension RestaurantPhotoItem {
    init(data: RestaurantPhoto) {
        self.date = data.date! as NSDate
        self.restaurantID = Int(data.restaurantID)
        self.photo = UIImage(data: data.photo!, scale: 1.0)
        if let uuid = data.uuid {
            self.uuid = uuid
        }
    }
}
