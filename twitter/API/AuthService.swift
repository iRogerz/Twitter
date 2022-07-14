//
//  AuthService.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/13.
//

import UIKit
import Firebase

struct AuthCredentials{
    let email:String
    let password:String
    let fullName:String
    let userName:String
    let pofileImage:UIImage
}

struct AuthService{
    static let shared = AuthService()
    
    func registerUser(credentials:AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void){
        let email = credentials.email
        let password = credentials.password
        let fullName = credentials.fullName
        let userName = credentials.userName
        
        guard let imageData = credentials.pofileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_POFILE_IMAGE.child(filename)
        
        
        storageRef.putData(imageData, metadata: nil) { meta, error in
            guard meta != nil  else {
                print("meta is nil")
                return
            }
            storageRef.downloadURL { url, error in
                guard let pofileImageURL = url?.absoluteString else {return}
                
                //建立帳戶
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error{
                        print("DEBUG:error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let values = ["email": email,
                                  "fullname": fullName,
                                  "username": userName,
                                  "pofileImageURL": pofileImageURL]
                    
                    //Database.database().reference()是連到database的url,child的user是database裡自訂的子分支,uid也是一樣的道理
        //            let ref = Database.database().reference().child("user").child(uid)
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
