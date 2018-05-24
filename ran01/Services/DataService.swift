//
//  DataService.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_FEED = DB_BASE.child("feed")
    private var _REF_ITEMS = DB_BASE.child("items")
    private var _REF_COMMENTS = DB_BASE.child("comments")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    var REF_ITEMS: DatabaseReference {
        return _REF_ITEMS
    }
    
    var REF_COMMENTS: DatabaseReference {
        return _REF_COMMENTS
    }

    // users
    // - email(user ID)
    // - provider
    // - friends
    //   - (ID) -> user ID
    // - favorite
    //   - (ID) -> feed ID
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
    
    
    
    
    
    
    private let properties = [
    Property(propertyItem: "Me"),
    Property(propertyItem: "Logout")
    ]
    
    func getProperties() -> [Property] {
        return properties
    }
    
    
    
}
