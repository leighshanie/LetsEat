//
//  ReviewFormViewController.swift
//  LetsEat
//
//  Created by Xinyi Li on 13/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {

    
    @IBOutlet weak var ratingsView: RatingsView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!

    @IBAction func onSaveTapped(_ sender: Any) {
        print(ratingsView.rating)
        print(tfTitle.text as Any)
        print(tfName.text as Any)
        print(tvReview.text)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
