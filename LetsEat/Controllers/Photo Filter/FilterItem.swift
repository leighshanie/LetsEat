//
//  FilterItem.swift
//  LetsEat
//
//  Created by Xinyi Li on 13/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class FilterItem: NSObject {
    
    let filter: String
    let name: String
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as! String
        filter = dict["filter"] as! String
        
        super.init()
    }
}
