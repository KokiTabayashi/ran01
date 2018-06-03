//
//  FollowerMemberVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/06/02.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class FollowerMemberVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var followersUserIdArray: [String] = []
    var followersArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _listAllFollower()
    }
    
    func _setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func _listAllFollower() {
        if let userId = Auth.auth().currentUser?.uid {
            DataService.instance.getAllFollowerFor(userId: userId) { (returnedFollowerIdArray) in
                self.followersUserIdArray = returnedFollowerIdArray
                for followerUserId in self.followersUserIdArray {
                    DataService.instance.getUsername(forUID: followerUserId, handler: { (returnedFollowerName) in
                        let userName = returnedFollowerName
                        let followerDetail = Friend(userId: followerUserId, userName: userName)
                        self.followersArray.append(followerDetail)
                        
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

extension FollowerMemberVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "followerMemberCell") as? FollowerMemberCell else { return UITableViewCell() }
        
        cell.configureCell(friendName: followersArray[indexPath.row].userName)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "<#SegueToViewController#>", sender: nil)
//    }
}
