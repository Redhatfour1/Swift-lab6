//
//  API.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/17/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import Foundation
import Accounts
import Social

typealias AccountsCompletion = (ACAccount?)->()
typealias TweetsCompletion = ([Tweet]?)->()

class API {
    static let shared = API()
    var account : ACAccount?
    private init() {}
    private func login(completion: @escaping AccountsCompletion) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            print("Welcome!")
            if error != nil {
                print("ERROR: \(error!)")
                completion(nil)
                return
            }
            if success {
                print("Successful, getting access to your Twitter Accounts!")
                if let accounts = accountStore.accounts(with: accountType) as? [ACAccount] {
                    completion(accounts.first) //stretch goal
                    return
                }
            }
            print("No error, but success is false")
            completion(nil)
        }
        print("The login function is complete and being cleared from memory")
    }
    private func updateTimeline(url: URL, completion: @escaping TweetsCompletion) {
//        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil)
        
        print("This is the server type for twitter: \(SLServiceTypeTwitter)")
        
        request?.account = self.account
        request?.perform(handler: { (data, response, error) in
            if error != nil {
                print("Error fetching HomeTimeline: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            guard let response = response else {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            switch response.statusCode {
            case 200...299:
                print("Successful!!!")
                JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                    completion(tweets)
                })
            case 400...499:
                print("Client-side error: \(response.statusCode)")
            case 500...599:
                print("Server-side error: \(response.statusCode)")
            default:
                print("Unrecognized status code: \(response.statusCode)")
            }
        })
        
    }
    func getTweets(completion: @escaping TweetsCompletion) {
        if self.account == nil {
            self.login(completion: { (account) in
                self.account = account
                if let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json") {
                    self.updateTimeline(url: url, completion: { (tweets) in
                        completion(tweets)
                    })
                }
            })
        } else {
            if let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json") {            self.updateTimeline(url: url, completion: { (tweets) in
                    completion(tweets)
                })
            }
        }
    }
    func getTweetsFor(username: String, completion: @escaping TweetsCompletion) {
        if let url = URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(username)") {
            self.updateTimeline(url: url, completion: { (tweets) in
            })
        }
    }
}
