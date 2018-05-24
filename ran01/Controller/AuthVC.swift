//
//  AuthVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
}
