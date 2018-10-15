//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Xinyi Li on 11/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit
import MapKit

public class RestaurantItem: NSObject, MKAnnotation, Decodable {
    public var name: String?
    public var cuisines:[String] = []
    public var latitude: Double?
    public var longitude: Double?
    public var address:String?
    public var postalCode:String?
    public var state:String?
    public var imageURL:String?
    
    public var restaurantID: Int?
    
    public init(dict:[String: AnyObject]) {
        if let lat = dict["lat"] as? Double { self.latitude = lat }
        if let lng = dict["lng"] as? Double { self.longitude = lng }
        if let name = dict["name"] as? String { self.name = name }
        if let cuisines = dict["cuisines"] as? [String] { self.cuisines = cuisines }
        if let address = dict["address"] as? String { self.address = address }
        if let postalCode = dict["postal_code"] as? String { self.postalCode = postalCode }
        if let state = dict["state"] as? String { self.state = state }
        if let imageURL = dict["image_url"] as? String { self.imageURL = imageURL }
    }
    
    public var subtitle: String? {
        if cuisines.isEmpty { return "" }
        else if cuisines.count == 1 { return cuisines.first }
        else { return cuisines.joined(separator: ", ") }
    }
    
    public var title: String? {
        return name
    }
    
    public var coordinate: CLLocationCoordinate2D {
        guard let lat = latitude, let long = longitude else {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    public enum CodingKeys: String, CodingKey {
        case name
        case cuisines
        case latitude = "lat"
        case longitude = "long"
        case address
        case postalCode = "postal_code"
        case state
        case imageURL = "image_url"
        case restaurantID = "id"
    }
}
