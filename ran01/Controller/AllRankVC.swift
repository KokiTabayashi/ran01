//
//  FirstViewController.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class AllRankVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rankingKey: String = ""
    var nameOfRankingOwner: String = ""
    var rankingArray: [Ranking] = []
    var rankItemsArray: [RankItem] = []
    var rankItemDetailArray: [RankItem] = []
    
    var rankItem = [Int: RankItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        let userId = DataService.instance.getCurrentUserId()
        
        let friendsAllay: [String] = []
        let favoritsAllay: [String] = []
        
        DataService.instance.getAllRankingFor(userId: userId, friendsAllay: friendsAllay, favoritesAllay: favoritsAllay) { (returnRanking) in
            self.rankingArray = returnRanking.reversed()

            self.tableView.reloadData()
        }
    }
}

extension AllRankVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allRankingItemCell", for: indexPath) as? AllRankingItemCell else {
            print("Fail to get allRankingItemCell")
            return UITableViewCell()
        }
        
        DataService.instance.getUsername(forUID: rankingArray[indexPath.row].userId) { (nameOfRankingOwner) in
            self.nameOfRankingOwner = nameOfRankingOwner
            
            
            
            // Test
            DataService.instance.getAllRankItemsFor(rankingKey: self.rankingArray[indexPath.row].rankingKey, handler: { (returnedRankItem) in
                self.rankItemsArray = returnedRankItem
                
                if self.rankItemsArray.count >= 3 {
                    self.rankItem[0] = self.rankItemsArray[0]
                    self.rankItem[1] = self.rankItemsArray[1]
                    self.rankItem[2] = self.rankItemsArray[2]
                } else if self.rankItemsArray.count == 2 {
                    self.rankItem[0] = self.rankItemsArray[0]
                    self.rankItem[1] = self.rankItemsArray[1]
                } else if self.rankItemsArray.count == 1 {
                    self.rankItem[0] = self.rankItemsArray[0]
                }
//                self.rankItem[0] = self.rankItemsArray[0]
//                self.rankItem[1] = self.rankItemsArray[1]
//                self.rankItem[2] = self.rankItemsArray[2]
                
                cell.configureCell(title: self.rankingArray[indexPath.row].title, nameOfRankingOwner: self.nameOfRankingOwner, dateRankingWasCreated: self.rankingArray[indexPath.row].date, profileOfOwner: "1", fried: "1", rankItemDetail: self.rankItem)
            })
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EachRankVC", sender: nil)
    }
}
