//
//  UserService.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/15.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase

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
}
