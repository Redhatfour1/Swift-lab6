//
//  SelectedViewController.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/29/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import UIKit

class SelectedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var selectedTimelineView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedTimeline: Tweet!
    var allTweets = [Tweet]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("selected tweet: \(selectedTimeline)")
        
        self.selectedTimelineView.dataSource = self
        
        let nib = UINib(nibName: "TweetCell", bundle: nil)
        self.selectedTimelineView.register(nib, forCellReuseIdentifier: "tweetCell")
        
        self.selectedTimelineView.rowHeight = UITableViewAutomaticDimension
        self.selectedTimelineView.estimatedRowHeight = 75
        
        API.shared.getTweetsFor (username: selectedTimeline.user!.screenName, completion: { (selectedTweets) in
            if let selectedTweets = selectedTweets {
                OperationQueue.main.addOperation {
                    self.allTweets = selectedTweets
                    self.activityIndicator.stopAnimating()
                    self.selectedTimelineView.reloadData()
                    print("Selected tweet\(selectedTweets)")
                }
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let currentTweet = self.allTweets[indexPath.row]
        
        cell.tweet = currentTweet

        return cell
    }
    
}
