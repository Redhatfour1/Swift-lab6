//
//  TweetCell.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/22/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
   
    @IBOutlet weak var tweetLabel: UILabel!

    @IBOutlet weak var profileImage: UIImageView!
    
    var tweet : Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            if let user = tweet.user {
                self.usernameLabel.text = user.name
                UIImage.fetchImagewith(urlString: user.profileImageURL, completion: {
                    (profileImage) in
                    self.profileImage.layer.cornerRadius = 10
                    self.profileImage.image = profileImage
                })
            }
        }
    }
}
