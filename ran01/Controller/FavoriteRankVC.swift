//
//  FavoriteRank.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class FavoriteRankVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var rankingKey: String = ""
    var nameOfRankingOwner: String = ""
    var rankingKeyArray: [String] = []
    var rankingArray: [Ranking] = []
    var rankItemsArray: [RankItem] = []
    var rankItemDetailArray: [RankItem] = []
    
    var rankItem = [Int: RankItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _getAllRanking()
    }
    
    func _setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func _getAllRanking() {
        DataService.instance.getCurrentUserId { (userId) in
            
            DataService.instance.getAllFavoriteRankingForUser(userId: userId) { (returnRanking) in
                self.rankingKeyArray = returnRanking
                
                DataService.instance.getAllFavoriteRankingForRankingKey(rankingKeyArray: self.rankingKeyArray, handler: { (returnRanking) in
                    self.rankingArray = returnRanking.reversed()
                    self.tableView.reloadData()
                })
                
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func searchBtnWasPressed(_ sender: Any) {
    }
}

extension FavoriteRankVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteRankingItemCell", for: indexPath) as? FavoriteRankingItemCell else {
            print("Fail to get allRankingItemCell")
            return UITableViewCell()
        }
        
        DataService.instance.getAllRankItemsAndUsernameFor(rankingKey: self.rankingArray[indexPath.row].rankingKey, uid: rankingArray[indexPath.row].userId, handler: { (returnedRankItem, returnedUsername) in
            self.rankItemsArray = returnedRankItem
            self.nameOfRankingOwner = returnedUsername
            
            self.rankItemsArray.sort(by: {$0.rank < $1.rank})
            
            if self.rankItemsArray.count >= 3 {
                self.rankItem[0] = self.rankItemsArray[0]
                self.rankItem[1] = self.rankItemsArray[1]
                self.rankItem[2] = self.rankItemsArray[2]
            } else if self.rankItemsArray.count == 2 {
                self.rankItem[0] = self.rankItemsArray[0]
                self.rankItem[1] = self.rankItemsArray[1]
                self.rankItem[2] = RankItem(rank: 0, title: "-", image: "-", explanation: "-", stars: [])
            } else if self.rankItemsArray.count == 1 {
                self.rankItem[0] = self.rankItemsArray[0]
                self.rankItem[1] = RankItem(rank: 0, title: "-", image: "-", explanation: "-", stars: [])
                self.rankItem[2] = RankItem(rank: 0, title: "-", image: "-", explanation: "-", stars: [])
            }
            //                self.rankItem[0] = self.rankItemsArray[0]
            //                self.rankItem[1] = self.rankItemsArray[1]
            //                self.rankItem[2] = self.rankItemsArray[2]
            
            cell.configureCell(title: self.rankingArray[indexPath.row].title, nameOfRankingOwner: self.nameOfRankingOwner, dateRankingWasCreated: self.rankingArray[indexPath.row].date, profileOfOwner: "1", fried: "1", rankItemDetail: self.rankItem)
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EachRankVC", sender: rankingArray[indexPath.row].rankingKey)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eachRankVC = segue.destination as? EachRankVC {
            eachRankVC.rankingKey = sender as! String
        }
    }
}


