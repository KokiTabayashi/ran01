//
//  AddUserVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class AddUserVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var errorMessageLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
    }
    
    
    @IBAction func createUserBtnWasPressed(_ sender: Any) {
        
        if emailTextField.text != nil && usernameTextField.text != nil && passwordTextField.text != nil && passwordConfirmTextField != nil {
            if passwordTextField.text == passwordConfirmTextField.text {
                errorMessageLbl.isHidden = true
                errorMessageLbl.text = ""
                
                AuthService.instance.registerUser(withEmail: emailTextField.text!, username: usernameTextField.text!, andPassword: passwordTextField.text!) { (success, registrationError) in
                    
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, loginComplete: { (success, nil) in
//                            self.dismiss(animated: true, completion: nil)
                            let AllRankVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                            self.present(AllRankVC!, animated: true, completion: nil)
                            print("Successfully registered a user")
                        })
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                        if let errorMessage = registrationError?.localizedDescription {
                            if errorMessage == "The email address is already in use by another account." {
                                self.errorMessageLbl.isHidden = false
                                self.errorMessageLbl.text = "error: The email address is already in use by another account."
                            }
                        }
                        
                    }
                    
                }
            } else {
                errorMessageLbl.isHidden = false
                errorMessageLbl.text = "error: your password and confirmation password do not match"
            }
        } else {
            errorMessageLbl.isHidden = false
            errorMessageLbl.text = "error: please fill in all the required information"
        }
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddUserVC: UITextFieldDelegate { }
