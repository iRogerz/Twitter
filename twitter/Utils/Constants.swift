//
//  Constants.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/29.
//

import Foundation
import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_POFILE_IMAGE = STORAGE_REF.child("pofile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("user")
//let REF_USER = Database.database().reference(withPath: "user")
