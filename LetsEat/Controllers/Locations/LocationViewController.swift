//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Xinyi Li on 10/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    let manager = LocationDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension LocationViewController {
    func initialize() {
        manager.fetch()
    }
}

extension LocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = manager.locationItem(at: indexPath)
        return cell
    }
    
}
