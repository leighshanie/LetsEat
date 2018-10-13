//
//  FilterManager.swift
//  LetsEat
//
//  Created by Xinyi Li on 13/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class FilterManager: DataManager {
    func fetch(completionHandler: (_ items: [FilterItem]) -> Swift.Void) {
        var items: [FilterItem] = []
        for data in load(file: "FilterData") {
        items.append(FilterItem(dict: data))
        }
        completionHandler(items)
    }
}
