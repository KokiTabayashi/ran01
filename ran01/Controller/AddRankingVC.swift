//
//  AddRankingVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/21.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class AddRankingVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rankingNameLbl: UILabel!
    
    var rankingKey: String = ""
    var rankItemsArray: [RankItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DataService.instance.getRankingTitle(forRankingKey: rankingKey) { (returnedRankingTitle) in
            self.rankingNameLbl.text = returnedRankingTitle
        }

        DataService.instance.getAllRankItemsFor(rankingKey: rankingKey) { (returnedRankItem) in
            self.rankItemsArray = returnedRankItem
        }
    }
    
    
    
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddRankingVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rankItemsArray.count + 1
        return rankItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addRankCell", for: indexPath) as? AddRankItemCell else {
            print("Fail to get addRankCell")
            return UITableViewCell()
        }
        
        if indexPath.row != rankItemsArray.count {
            let rankItem = rankItemsArray[indexPath.row]

            if rankItem.title != "" {
                cell.configureCell(rank: rankItem.rank, title: rankItem.title, itemImage: rankItem.image, explanation: rankItem.explanation)
            } else {
                cell.configureCell(rank: 0, title: "Add Item?", itemImage: "-", explanation: "-")
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "AddRankDetailVC", sender: rankingKey)

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let addRankDetailVC = segue.destination as? AddRankDetailVC {
//            addRankDetailVC.rankingKey = sender as! String
//        }
//    }
}
