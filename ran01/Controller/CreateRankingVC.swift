//
//  CreateRankingVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/24.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class CreateRankingVC: UIViewController {
    
    @IBOutlet weak var rankingNameTextField: UITextField!
    @IBOutlet weak var errorMessageLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLbl.isHidden = true
    }
    
    @IBAction func createBtnWasPressed(_ sender: Any) {
        if rankingNameTextField.text != nil && rankingNameTextField.text != "" {
            
            if let userID = Auth.auth().currentUser?.uid {
                DataService.instance.registerRanking(withTitle: rankingNameTextField.text!, userId: userID) { (success, rankingKey) in
                    if success && rankingKey != "" {
                        
                        let rankingKey: String = rankingKey
                        self.performSegue(withIdentifier: "AddRankingVC", sender: rankingKey)
                        
                    } else {
                        self.errorMessageLbl.isHidden = false
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addRankingVC = segue.destination as? AddRankingVC {
            addRankingVC.rankingKey = sender as! String
        }
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
