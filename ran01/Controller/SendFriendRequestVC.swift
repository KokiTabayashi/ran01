//
//  SendFriendRequestVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/06/01.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class SendFriendRequestVC: UIViewController {
    
    @IBOutlet weak var friendNameLbl: UILabel!
    
    var friend = Friend(userId: "User ID", userName: "User Name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendNameLbl.text = friend.userName
    }
    
    @IBAction func yesBtnWasPressed(_ sender: Any) {
        DataService.instance.addFriend(friendsUserId: friend.userId) { (success) in
            
        }
    }
    
    @IBAction func noBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
