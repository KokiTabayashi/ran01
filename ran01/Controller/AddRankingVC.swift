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
    @IBOutlet weak var addNextItemBtn: UIButton!
    
    var rankingKey: String = ""
    var rankItemsArray: [RankItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _getRankingTitle()
        _getAllRankItems()
    }
    
    func _setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func _getRankingTitle() {
        DataService.instance.getRankingTitleTmp(forRankingKey: rankingKey) { (returnedRankingTitle) in
            self.rankingNameLbl.text = returnedRankingTitle
            self.tableView.reloadData()
        }
    }

    func _getAllRankItems() {
        DataService.instance.getAllRankItemsForTmp(rankingKey: rankingKey) { (returnedRankItem) in
            self.rankItemsArray = returnedRankItem
            self.tableView.reloadData()
            
            DataService.instance.getNumberOfItemsTmp(forRankingKey: self.rankingKey, handler: { (numberOfItems) in
                if self.rankItemsArray.count == numberOfItems {
                    self.addNextItemBtn.isHidden = true
                }
            })
        }
    }
    
    @IBAction func submitBtnWasPressed(_ sender: Any) {
        
        // get temp registered Ranking information
        DataService.instance.getRankingInfoTmp(forRankingKey: rankingKey) { (returnedRankingTitle, returnedUserId, returnedNumberOfItems) in
            
            // register official information
            DataService.instance.registerRanking(withTitle: returnedRankingTitle, userId: returnedUserId, numberOfItems: returnedNumberOfItems, registerRankingComplete: { (success, returnedOfficialRankingKey) in
                
                if success {
                    // get temp detail item information
                    DataService.instance.getAllRankItemsForTmp(rankingKey: self.rankingKey, handler: { (returnedRankingItemsArray) in
                        for rankingItem in returnedRankingItemsArray {
                            
                            // register official detail item information
                            DataService.instance.addRankingItemDetail(withRank: rankingItem.rank, title: rankingItem.title, explanation: rankingItem.explanation, image: rankingItem.image, withRankingKey: returnedOfficialRankingKey, addDetailComplete: { (success) in
                                
                                let allRankVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                                self.present(allRankVC!, animated: true, completion: nil)
                                
                            })
                        }
                    })
                }
            })
        }
    }
    
    @IBAction func addNextItemBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddRankDetailVC", sender: nil)
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addRankDetailVC = segue.destination as? AddRankDetailVC {
            addRankDetailVC.rankingKey = rankingKey
        }
    }
}

extension AddRankingVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addRankCell", for: indexPath) as? AddRankItemCell else {
            print("Fail to get addRankCell")
            return UITableViewCell()
        }
        
        rankItemsArray.sort(by: {$0.rank < $1.rank})
        
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
    }
}
