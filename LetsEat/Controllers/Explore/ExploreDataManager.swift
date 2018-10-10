//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by Xinyi Li on 10/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import Foundation

class ExploreDataManager: DataManager {
    
    fileprivate var items:[ExploreItem] = []
    
    
    func fetch() {
        for data in load(file: "ExploreData") {
            items.append(ExploreItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index:IndexPath) -> ExploreItem {
        return items[index.item]
    }
    
//    fileprivate func loadData() -> [[String: AnyObject]] {
//        guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
//            let items = NSArray(contentsOfFile: path) else {
//                return [[:]]
//        }
//
//        return items as! [[String: AnyObject]]
//    }
}
