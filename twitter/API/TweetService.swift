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
        
        //        let ref = REF_TWEETS.childByAutoId()
        
        //childByAutoId是用來生成uid的
        REF_TWEETS.childByAutoId().updateChildValues(values) { error, ref in
            //update user-tweets after tweet upload complete
            guard let tweetID = ref.key else { return }
            REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
        }
    }
    
    func fetchTweets(completion:@escaping([Tweet])-> Void){
        var tweets = [Tweet]()
        
        //.childadded 每次只要有新的子節點新增，就拿取裡面的資訊
        REF_TWEETS.observe(.childAdded) { snapshot in
            //            print("DEBUG: snapshot is \(snapshot.value)")
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user:user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
            
        }
    }
    
    
    func fetchTweets(forUser user: User, completion:@escaping([Tweet])-> Void){
        
        var tweets = [Tweet]()
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            let tweetID = snapshot.key
            
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                
                UserService.shared.fetchUser(uid: uid) { user in
                    let tweet = Tweet(user:user, tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
}
