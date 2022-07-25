//
//  TweetService.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/23.
//


import Firebase
import FirebaseAuth
import FirebaseDatabase

struct TweetService{
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retreet": 0,
                      "caption": caption] as [String: Any]
        
        //childByAutoId是用來生成uid的
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
}
