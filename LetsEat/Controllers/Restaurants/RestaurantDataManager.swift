//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Xinyi Li on 11/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import Foundation

class RestaurantDataManager {
    private var items: [RestaurantItem] = []
    
    func fetch(by location: String, withFilter: String = "All", completionHandler:(_ items:[RestaurantItem]) -> Swift.Void) {
        if let file = Bundle.main.url(forResource: location, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let restaurants = try JSONDecoder().decode([RestaurantItem].self, from: data)
            
    //        var restaurants: [RestaurantItem] = []
    //        for restaurant in RestaurantAPIManager.loadJSON(file: location) {
    //            restaurants.append(RestaurantItem(dict: restaurant))
    //        }
                if withFilter != "All" {
                    items = restaurants.filter({ ($0.cuisines.contains(withFilter)) })
                } else {
                    items = restaurants
                }
            }
            catch {
                print("there was an error \(error)")
            }
        }
        
        completionHandler(items)
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func restaurantItem(at index: IndexPath) -> RestaurantItem {
        return items[index.item]
    }
}
