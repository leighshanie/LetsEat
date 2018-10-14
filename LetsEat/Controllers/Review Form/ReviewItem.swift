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
    var title: String?
    var name: String?
    var customerReview: String?
    var date: NSDate?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yy"
        guard let reviewDate = date else { return "" }
        return formatter.string(from: reviewDate as Date)
    }
}

extension ReviewItem {
    init(data: Review) {
        self.customerReview = data.customerReview
        self.name = data.name
        self.title = data.title
        self.restaurantID = Int(data.restaurantID)
        self.rating = data.rating
        if let uuid = data.uuid {
            self.uuid = uuid
        }
        if let reviewDate = data.date { self.date = reviewDate as NSDate }
    }
}
