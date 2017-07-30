//
//  UIExtensions.swift
//  Swift-lab-6
//
//  Created by Louis W. Haywood on 7/29/17.
//  Copyright © 2017 Louis W. Haywood. All rights reserved.
//

import UIKit
typealias ImageCompletion = (UIImage?)->()

extension UIImage {
    class func fetchImagewith(urlString: String, completion: @escaping ImageCompletion) {
        OperationQueue().addOperation {
            if let url = URL(string: urlString) {
                do {
                    let data = try Data(contentsOf: url)
                    completion(UIImage(data: data))
                } catch {
                    print("There is an error with getting data from url: Error:\(error)")
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                }
            }
        }
    }
}
