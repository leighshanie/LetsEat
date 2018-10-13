//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Xinyi Li on 11/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
    
    // Nav Bar
    @IBOutlet weak var btnHeart: UIBarButtonItem!
    
    //Cell One
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    
    //Cell Two
    @IBOutlet weak var lblTableDetails: UILabel!
    
    //Cell Three
    @IBOutlet weak var lblOverallRating: UILabel!
    
    //Cell Eight
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgMap: UIImageView!
    
    @IBOutlet weak var ratingsView: RatingsView!
    
    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dump(selectedRestaurant as Any)
        initialize()
    }
    
    func initialize() {
        setupLabels()
        createMap()
        createRating()
    }
}

private extension RestaurantDetailViewController {
    
    func createRating() {
        ratingsView.rating = 3.5
        ratingsView.isEnabled = true
    }
    
    func setupLabels() {
        guard let restaurant = selectedRestaurant else { return }
        if let name = restaurant.name {
            lblName.text = name
            title = name
        }
        
        if let cuisine = restaurant.subtitle { lblCuisine.text = cuisine }
        if let address = restaurant.address {
            lblAddress.text = address
            lblHeaderAddress.text = address
        }
        
        lblTableDetails.text = "Table for 7, tonight at 10:00 PM"
    }
    
    func createMap() {
        guard let annotation = selectedRestaurant, let long = annotation.longitude,
            let lat = annotation.latitude else { return }
        let location = CLLocationCoordinate2D (
            latitude: lat,
            longitude: long
        )
        takeSnapShot(with: location)
    }
    
    func takeSnapShot(with location: CLLocationCoordinate2D) {
        let options = MKMapSnapshotter.Options()
        var loc = location
        let polyLine = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyLine.boundingMapRect)
        
        options.region = region
        options.scale = UIScreen.main.scale
        options.size = CGSize(width: 340, height: 208)
        options.showsBuildings = true
        options.showsPointsOfInterest = true
        
        let snapShotter = MKMapSnapshotter(options: options)
        snapShotter.start() {
            snapshot, error in guard let snapshot = snapshot else {
                return
            }
            UIGraphicsBeginImageContextWithOptions(options.size, true, 0)
            snapshot.image.draw(at: .zero)
            
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            
            var point = snapshot.point(for: location)
            let rect = self.imgMap.bounds
            
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width / 2
                point.y -= pinView.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
        }
    }
}
