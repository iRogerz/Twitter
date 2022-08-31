//
//  UserService.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/15.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase


//typealias用來簡化程式碼
typealias DatebaseCompletion = ((Error?, DatabaseReference) -> Void)

struct UserService{
    static let shared = UserService()
    
    func fetchUser(uid: String, complition: @escaping(User) -> Void){
//        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //observe用來監聽每次
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:AnyObject] else { return }
//            print("DEBUG: dictionary is \(dictionary)")
            
            let user = User(uid: uid, dictionary: dictionary)
            
            complition(user)
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void){
        var users = [User]()
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    func followUser(uid: String, completion: @escaping(DatebaseCompletion)) {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }

        REF_USER_FOLLOWING.child(currentUser).updateChildValues([uid: 1]) { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUser: 1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping(DatebaseCompletion)) {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        REF_USER_FOLLOWING.child(currentUser).child(uid).removeValue { err, ref in
            REF_USER_FOLLOWERS.child(uid).child(currentUser).removeValue(completionBlock: completion)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        REF_USER_FOLLOWING.child(currentUser).child(uid).observeSingleEvent(of: .value) { snapshot in
//            print(snapshot.exists())
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping(UserRelationStats) -> Void) {
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            let followers = snapshot.children.allObjects.count
            
            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { snapshot in
                let following = snapshot.children.allObjects.count
                
                let stats = UserRelationStats(followers: followers, following: following)
                completion(stats)
            }
        }
    }
}
