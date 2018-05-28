//
//  LoginVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginBtnWasPressed(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField != nil {
            AuthService.instance.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!) { (success, loginError) in
                
                if success {
//                    self.dismiss(animated: true, completion: nil)
                    let AllRankVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                    self.present(AllRankVC!, animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                    self.errorMessageLbl.isHidden = false
                }
            }
        }
    }

    
    @IBAction func createBtnWasPressed(_ sender: Any) {
        let AddUserVC = storyboard?.instantiateViewController(withIdentifier: "AddUserVC")
        present(AddUserVC!, animated: true, completion: nil)
    }
    
    @IBAction func screenWasTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate { }
