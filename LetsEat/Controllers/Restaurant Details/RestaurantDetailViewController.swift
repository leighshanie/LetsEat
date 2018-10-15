//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Xinyi Li on 11/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit
import MapKit
import LetEatDataKit
import UserNotifications

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
    let manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dump(selectedRestaurant as Any)
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showReview.rawValue:
                showReview(segue: segue)
            case Segue.showPhotoFilter.rawValue:
                showPhotoFilter(segue: segue)
            default:
                print("Segue not added \(identifier)")
            }
        }
    }
}

private extension RestaurantDetailViewController {
    
    func initialize() {
        setupLabels()
        createMap()
        createRating()
        setupNotificationDefaults()
    }
    
    func setupNotificationDefaults() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    func showReview(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
        let viewController = navController.topViewController as? ReviewFormViewController else {
            return
        }
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func showPhotoFilter(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? PhotoFilterViewController else {
                return
        }
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func createRating() {
        if let id = selectedRestaurant?.restaurantID {
            let value = manager.fetchRestaurantRating(by: id)
            ratingsView.rating = CGFloat(value)
            if value.isNaN { lblOverallRating.text = "0" }
            else {
                lblOverallRating.text = String(format: "%.1f", value)
                
            }
        }
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
    
    // MARK: Create Map Annotations
    func createMap() {
        guard let annotation = selectedRestaurant, let lng = annotation.longitude,
            let lat = annotation.latitude else { return }
        let location = CLLocationCoordinate2D (
            latitude: lat,
            longitude: lng
        )
        print(location)
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
    
    // MARK: cancel unwind
    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue) {}
    @IBAction func unwindPhotoReviewCancel(segue:UIStoryboardSegue) {}
    
    func showNotification(sender: String?) {
        print(sender as Any)
        let content = UNMutableNotificationContent()
        if let name = selectedRestaurant?.name { content.title = name }
        if let time = sender { content.body = "Table for 7, tonight at \(time)" }
        content.subtitle = "Restaurant Reservation"
        content.badge = 1
        
        // Only tested on simulator without sound
        content.sound = UNNotificationSound.default
        
        content.categoryIdentifier = "reservationCategory"
        
        // MARK: test examples
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let identifier = "LetsEatReservation"
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
//            //handle error
//        })
        
        do {
            let url = Bundle.main.url(forResource: "sample-restaurant-img@3x", withExtension: "png")
            if let imgURL = url {
                let attachment = try UNNotificationAttachment(identifier: "letsEatReservation", url: imgURL, options: nil)
                content.attachments = [attachment]
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let identifier = "letsEatReservation"
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    //handle error
                })
            }
        }
        catch {
            print("there was an error with the notification")
        }
    }
    
    @IBAction func onTimeTapped(sender: UIButton) {
        showNotification(sender: sender.titleLabel?.text)
    }
}

extension RestaurantDetailViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let identifier = Option(rawValue: response.actionIdentifier) {
            switch identifier {
            case .one:
                print("User selected yes")
            case .two:
                print("User selected no")
            }
        }
        completionHandler()
    }
}
