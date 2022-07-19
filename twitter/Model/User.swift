//
//  User.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/15.
//

import Foundation

struct User{
    let fullname: String
    let email: String
    let username: String
    let pofileImageURL: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]){
        self.uid = uid
        //要加as?的原因是因為預設dictionary的value是anyobject, 但要存成變數所以要變成string
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.pofileImageURL = dictionary["pofileImageURL"] as? String ?? ""
        
        
    }
}
