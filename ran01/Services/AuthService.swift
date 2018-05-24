//
//  AuthService.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let friendsArray: [String] = []
            let favoriteArray: [String] = []
            
            let userData = ["provider": user.providerID, "email": user.email as Any, "friends": friendsArray, "favorite": favoriteArray] as [String : Any]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }        
    }
    
    
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
