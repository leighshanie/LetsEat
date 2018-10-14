//
//  DataManager.swift
//  LetsEat
//
//  Created by Xinyi Li on 11/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import Foundation

protocol DataManager {
    
    func load(file name: String) -> [[String: AnyObject]]
}

extension DataManager {
    func load(file name:String) -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let items = NSArray(contentsOfFile: path) else {
                return [[:]]
        }
        return items as! [[String: AnyObject]]
    }
}

