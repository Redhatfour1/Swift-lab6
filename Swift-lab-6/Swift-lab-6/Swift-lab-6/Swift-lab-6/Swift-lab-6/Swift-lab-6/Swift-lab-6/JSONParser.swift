//
//  JASONParser.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/10/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import Foundation

typealias JSONParserCallback = (Bool, [Tweet]?)->()

class JSONParser {
    
    static var sampleTweetData : Data {
        guard let path = Bundle.main.url(forResource: "Tweet", withExtension: "json") else { fatalError("The path for Tweet.json is not working!")}
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            fatalError(error.localizedDescription)
        }
    }
        
    class func tweetsFrom(data: Data, callback: JSONParserCallback) {
         do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                var allTweets = [Tweet]()
                for tweetJSON in rootObject {
                    guard let newTweet = Tweet(json: tweetJSON) else { continue }
                    allTweets.append(newTweet)
                    }
                callback(true, allTweets)
                }
            } catch {
            print(error)
        
            }
    
    }
}

