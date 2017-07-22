//
//  Tweet.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/8/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import Foundation

class Tweet {
    let text: String
    let id: String
    
    var user: User?
    
    init?(json: [String: Any]) {
        
        if let text = json["text"] as? String,
            let id = json["id_str"] as? String,
            let userJson = json["user"] as? [String: Any] {
            
            self.text = text
            self.id = id
            self.user = User(json: userJson)
            
            
        } else {
            return nil
        }
    }
}
