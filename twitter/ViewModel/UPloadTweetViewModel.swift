//
//  UPloadTweetViewModel.swift
//  twitter
//
//  Created by 曾子庭 on 2022/10/16.
//

import Foundation

//為了要發文跟回覆文用一樣的框架
enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UPloadTweetViewModel {
    
    let actionbuttonTitle: String
    let placeholderText: String
    var shouldShowReplyLabel: Bool
    var replyText: String?
      
    init(config: UploadTweetConfiguration){
        switch config {
        case .tweet:
            actionbuttonTitle = "Tweet"
            placeholderText = "What's happening"
            shouldShowReplyLabel = false
        case .reply(let tweet):
            actionbuttonTitle = "Reply"
            placeholderText = "Tweet your Reply"
            shouldShowReplyLabel = true
            replyText = "Reply to \(tweet.user.username )"
        }
    }
}
