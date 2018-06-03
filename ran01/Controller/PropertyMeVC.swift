//
//  PropertyMeVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class PropertyMeVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addUserDateLbl: UILabel!
    @IBOutlet weak var numberOfFollowBtn: UIButton!
    @IBOutlet weak var numberOfFollowerBtn: UIButton!
    
    var friendsUserIdArray: [String] = []
    var followersUserIdArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
        addUserDateLbl.text = TimeService.instance.getAddUserDate()
        
        if let userId = Auth.auth().currentUser?.uid {
            DataService.instance.getUsername(forUID: userId) { (returnedUsername) in
                self.usernameLbl.text = returnedUsername
            }
            
            DataService.instance.getAllFriendFor(userId: userId) { (returnedFriendsArray) in
                self.friendsUserIdArray = returnedFriendsArray
                self.numberOfFollowBtn.setTitle("\(self.friendsUserIdArray.count)", for: .normal)
            }
            
            DataService.instance.getAllFollowerFor(userId: userId) { (returnedFollowersArray) in
                self.followersUserIdArray = returnedFollowersArray
                self.numberOfFollowerBtn.setTitle("\(self.followersUserIdArray.count)", for: .normal)
            }
        }
    }
    
    @IBAction func numberOfFollowBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "FollowMemberVC", sender: nil)
    }
    
    @IBAction func numberOfFollowerBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "FollowerMemberVC", sender: nil)
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
