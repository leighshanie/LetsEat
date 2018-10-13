//
//  ReviewDataManager.swift
//  LetsEat
//
//  Created by Xinyi Li on 14/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class ReviewDataManager: NSObject {
    private var reviewItems: [ReviewItem] = []
    private var photoItems: [RestaurantPhotoItem] = []
    let manager = CoreDataManager()
    func fetchReview(by restaurantID: Int) {
        if reviewItems.count > 0 {
            reviewItems.removeAll()
        }
        for data in manager.fetchReview(by: restaurantID) {
            reviewItems.append(data)
        }
    }
    
    func fetchPhoto(by restautantID: Int) {
        if photoItems.count > 0 { photoItems.removeAll() }
        for data in manager.fetchPhotos(by: restautantID) {
            photoItems.append(data)
        }
    }
    
    func numberOfReviewItems() -> Int {
        return reviewItems.count
    }
    
    func numberOfPhotoItems() -> Int {
        return photoItems.count
    }
    
    func reviewItem(at index: IndexPath) -> ReviewItem {
        return reviewItems[index.item]
    }
    
    func photoItem(at index: IndexPath) -> RestaurantPhotoItem {
        return photoItems[index.item]
    }
}
