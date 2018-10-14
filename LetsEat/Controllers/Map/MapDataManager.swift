//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Xinyi Li on 11/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import Foundation
import MapKit

class MapDataManager: DataManager {
    
    fileprivate var items:[RestaurantItem] = []
    
    var annotations:[RestaurantItem] {
        return items
    }
    
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else {
            return MKCoordinateRegion()
        }
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
    // closure block
    func fetch(with completion: (_ annotations:[RestaurantItem]) -> ()) {

        if items.count > 0 { items.removeAll() }

        for data in load(file: "MapLocations") {
            items.append(RestaurantItem(dict: data))
        }
        completion(items)
    }
    
//    func fetch(with completion: (_ annotations:[RestaurantItem]) -> ()) {
//        let manager = RestaurantDataManager()
//        manager.fetch(by: "Chicago") { (items) in
//            self.items = items
//            completion(items)
//        }
//    }
}
