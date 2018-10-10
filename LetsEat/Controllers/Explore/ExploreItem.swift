//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Xinyi Li on 10/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import Foundation

struct ExploreItem {
    var name:String?
    var image:String?
}

//AnyObject
extension ExploreItem {
    init(dict:[String:AnyObject]) {
        self.name = dict["name"] as? String
        self.image = dict["image"] as? String
    }
}
