//
//  ViewController.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/8/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var allTweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 75
        
//        JSONParser.tweetsFrom(data: JSONParser.sampleTweetData) { (success, allTweets) in guard let allTweets = allTweets else { return }
//            
//            self.allTweets = allTweets
//            self.tableView.reloadData()
//        }
        
        
        API.shared.getTweets { (tweets) in
            if let tweets = tweets {
                OperationQueue.main.addOperation {
                    self.allTweets = tweets
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "detailViewController" {
        
        if let selectedIndex = self.tableView.indexPathForSelectedRow {
            let selectedTweet = self.allTweets[selectedIndex.row]
    
            
            if let destinationController = segue.destination as? DetailViewController {
                destinationController.selectedTweet = selectedTweet
            }
          }
       }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let currentTweet = self.allTweets[indexPath.row]
        
        cell.usernameLabel.text = currentTweet.user?.name
        cell.tweetLabel.text = currentTweet.text
        
//        cell.textLabel?.text = currentTweet.user?.name
//        cell.detailTextLabel?.text = "\(currentTweet.id) - \(currentTweet.text)"
        
        return cell
    }
}
