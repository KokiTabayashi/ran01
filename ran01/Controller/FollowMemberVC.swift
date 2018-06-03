//
//  FollowMemberVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/06/02.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class FollowMemberVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var friendsUserIdArray: [String] = []
    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _listAllFollowUser()
    }
    
    func _setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func _listAllFollowUser() {
        if let userId = Auth.auth().currentUser?.uid {
            DataService.instance.getAllFriendFor(userId: userId) { (returnedUserIdArray) in
                self.friendsUserIdArray = returnedUserIdArray
                for friendUserId in self.friendsUserIdArray {
                    DataService.instance.getUsername(forUID: friendUserId, handler: { (returnedUserName) in
                        let userName = returnedUserName
                        let friendDetail = Friend(userId: friendUserId, userName: userName)
                        self.friendsArray.append(friendDetail)

                        self.tableView.reloadData()
                    })
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func searchBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension FollowMemberVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "followMemberCell") as? FollowMemberCell else { return UITableViewCell() }
        
        cell.configureCell(friendName: friendsArray[indexPath.row].userName)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "<#SegueToViewController#>", sender: nil)
//    }
}
