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
    var allTweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
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
                }
                
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        let currentTweet = self.allTweets[indexPath.row]
        
        cell.textLabel?.text = currentTweet.user?.name
        cell.detailTextLabel?.text = currentTweet.text
        
        return cell
    }
}
