//
//  PropertyLogoutVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class PropertyLogoutVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func yesBtnWasPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
            self.present(authVC!, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    @IBAction func noBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
