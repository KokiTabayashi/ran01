//
//  AddCommentVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/22.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class AddCommentVC: UIViewController {
    
    @IBOutlet weak var tableView_Rank: UITableView!
    @IBOutlet weak var tableView_Comment: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView_Rank: tag 10
        tableView_Rank.delegate = self
        tableView_Rank.dataSource = self
        
        // tableView_Comment: tag 20
        tableView_Comment.delegate = self
        tableView_Comment.dataSource = self
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddCommentVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 10 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RankCell") else { return UITableViewCell() }
            return cell
        }
        
        if tableView.tag == 20 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") else { return UITableViewCell() }
            return cell
        }
        
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "<#SegueToViewController#>", sender: nil)
//    }
}
