//
//  PropertyLogoutVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class PropertyLogoutVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func yesBtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func noBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
