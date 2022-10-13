//
//  TweetViewModel.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/31.
//

import Foundation
import UIKit

struct TweetViewModel{
    
    let tweet: Tweet
    let user: User
    
    var pofileImageUrl: URL?{
        return tweet.user.pofileImageURL
    }
    var timestamp: String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        //在formatter只顯示一個時間，也可以設定2個以上，不設定就會把allowedUnits內全部都顯示出來
        formatter.maximumUnitCount = 1
        //顯示的形式有很多種style可以選
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var headerTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ・ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var retweetsAttributedString: NSAttributedString {
        return attributedText(value: tweet.retreet, text: "Retweets")
    }
    
    var likesAttributedString: NSAttributedString {
        return attributedText(value: tweet.likes, text: "Likes")
    }
    
    var userInfoText: NSAttributedString{
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                                  .foregroundColor: UIColor.lightGray]))
        title.append(NSAttributedString(string: " ・\(timestamp)", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                                  .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    
    init(tweet: Tweet){
        self.tweet = tweet
        self.user = tweet.user
    }
    
    
    fileprivate func attributedText(value: Int, text: String) -> NSAttributedString{
        let attributedTitle = NSMutableAttributedString(string: "\(value) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14),                                                                            .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
    
    
    //要再研究一下這是讓留言的cell大小自適應不會擋到下面的四個icon
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
        
        measurementLabel.text = tweet.caption
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.snp.makeConstraints { make in
            make.width.equalTo(width)
        }
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
    }
}
