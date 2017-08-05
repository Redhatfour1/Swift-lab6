//
//  DetailViewController.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/22/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func viewFeedButton(_ sender: Any) {
    }
    
    
    var selectedTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameLabel.text = selectedTweet.user?.name
        self.locationLabel.text = selectedTweet.user?.location
        self.textLabel.text = selectedTweet.text
        self.activityIndicator.stopAnimating()
        
//        print("DetailViewController got the following Tweet:")
//        print(selectedTweet.user?.name)
//        print(selectedTweet.user?.location)
//        print(selectedTweet.text)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "selectedTimelineSegue" {
            if let destination = segue.destination as?
                SelectedViewController {
                destination.selectedTimeline = self.selectedTweet
            }
        }
    }
}
