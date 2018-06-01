//
//  PropertyFindFriends.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/30.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class PropertyFindFriends: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var friendsName = ""
    var friendsArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _findFriends(name: friendsName)
    }
    
    func _setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func _findFriends(name: String) {
        DataService.instance.findFriends(withName: name) { (returnedFriends) in
            self.friendsArray = returnedFriends
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func searchBtnWasPressed(_ sender: Any) {
        if let search = searchField.text {
            friendsName = search
            _findFriends(name: friendsName)
        }
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PropertyFindFriends: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "propertyFriendsCell") as? PropertyFindFriendsCell else { return UITableViewCell() }
        
        cell.configureCell(friendName: friendsArray[indexPath.row])
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "<#SegueToViewController#>", sender: nil)
//    }
}
