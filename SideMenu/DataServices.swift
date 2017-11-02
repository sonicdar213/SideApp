//
//  DataServices1.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 10/28/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_base = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()
class DataServices {
    
    static let ds = DataServices()
    
    // DB references
    private var _REF_BASE = DB_base
    private var _REF_POSTS = DB_base.child("post")
    private var _REF_USERS = DB_base.child("users")
    
    //Storage references
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-image")
    var REF_BASE:DatabaseReference{
        return _REF_BASE
    }
    var REF_POST:DatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS:DatabaseReference{
        return _REF_USERS
    }
    var REF_POST_IMAGEs : StorageReference{
        return _REF_POST_IMAGES
    }
    var REF_USERS_CURRENT:DatabaseReference  {
        //        let uid = KeychainWrapper.string(Key_UID)
        //        let user =  REF_USERS.child(uid)
        let uid = KeychainWrapper.defaultKeychainWrapper.string(forKey: Key_UID)
        let user = REF_USERS.child(uid!)
        return user
        
    }
    
    func createFirebaseDBUser(uid:String , userDATA:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userDATA)
    }
}
