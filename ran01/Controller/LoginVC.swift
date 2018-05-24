//
//  LoginVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func loginBtnWasPressed(_ sender: Any) {
    }
    
}
