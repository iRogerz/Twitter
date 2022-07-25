//
//  UserService.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/15.
//

import Firebase
import FirebaseAuth

struct UserService{
    static let shared = UserService()
    
    func fetchUser(complition: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observe(.value) { snapshot in
            guard let dictionary = snapshot.value as? [String:AnyObject] else { return }
//            print("DEBUG: dictionary is \(dictionary)")
            
            let user = User(uid: uid, dictionary: dictionary)
            
            complition(user)
        }
    }
}
