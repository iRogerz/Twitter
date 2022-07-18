//
//  UserService.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/15.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserService{
    static let shared = UserService()
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observe(.value) { snapshot in
            print(snapshot)
            guard let dictionary = snapshot.value as? [String:AnyObject] else { return }
            print("DEBUG: dictionary is \(dictionary)")
            guard let username = dictionary["username"] as? String else { return }
            print("DEBUG: username is \(username)")
        }
    }
}
