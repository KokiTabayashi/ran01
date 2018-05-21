//
//  FirstViewController.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class AllRankVC: UIViewController {

    @IBOutlet weak var parentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentTableView.delegate = self
        parentTableView.dataSource = self
    }
}

extension AllRankVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = parentTableView.dequeueReusableCell(withIdentifier: "parentTableCell") as? UITableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
