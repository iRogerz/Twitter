//
//  Tweet.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/25.
//

import Foundation

struct Tweet{
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    var timestamp: Date
    let retreet: Int
    let user: User
    
    init(user: User, tweetID: String, dictionary: [String: Any]){
        self.tweetID = tweetID
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retreet = dictionary["retreet"] as? Int ?? 0
        self.timestamp = Date(timeIntervalSince1970: dictionary["timestamp"] as? Double ?? 0)
//        if let timestamp = dictionary["timestamp"] as? Double{
//            self.timestamp = Date(timeIntervalSince1970: timestamp)
//        }
    }
}
