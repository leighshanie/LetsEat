//
//  ReviewItem.swift
//  LetsEat
//
//  Created by Xinyi Li on 13/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

struct ReviewItem {
    var rating: Float?
    var name: String?
    var customerReview: String?
    var date: NSDate?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: self.date! as Date)
    }
}

extension ReviewItem {
    init(data: Review) {
        self.date = (data.date! as NSDate)
        self.customerReview = data.customerReview
        self.name = data.name
        self.restaurantID = Int(data.restaurantID)
        self.rating = data.rating
        if let uuid = data.uuid {
            self.uuid = uuid
        }
    }
}
