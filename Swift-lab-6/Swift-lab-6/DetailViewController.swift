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
    
    var selectedTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameLabel.text = selectedTweet.user?.name
        self.locationLabel.text = selectedTweet.user?.location
        self.textLabel.text = selectedTweet.text
        
//        print("DetailViewController got the following Tweet:")
//        print(selectedTweet.user?.name)
//        print(selectedTweet.user?.location)
//        print(selectedTweet.text)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectedViewController", sender: nil)
    }
}
