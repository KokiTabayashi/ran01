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
    
    var numberOfRowInTableView = 10
    
    // Test
    var rankingKey: String = "-LDKmSBGqH6iJ8Z8UaZZ"
    var rankingTitle: String = ""
    
    var rankingArray: [Ranking] = []
    var rankItemsArray: [RankItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        DataService.instance.getRankingTitle(forRankingKey: rankingKey) { (returnedRankingTitle) in
//            self.rankingTitle = returnedRankingTitle
//
//            // Test -> Succeeded.
//            print(returnedRankingTitle)
//        }
//
//        self.tableView.reloadData()
////        DataService.instance.getAllRankItemsFor(rankingKey: rankingKey) { (returnedRankItem) in
////            self.rankItemsArray = returnedRankItem
////        }
//    }
    
    // try View Did Appear -> Succeeded
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        let userId = DataService.instance.getCurrentUserId()
        
        // for now
        var friendsAllay: [String] = []
        var favoritsAllay: [String] = []
        
        DataService.instance.getRankingTitle(forRankingKey: rankingKey) { (returnedRankingTitle) in
            self.rankingTitle = returnedRankingTitle
            
            // Test -> Succeeded.
//            print(returnedRankingTitle)
        }
        
        DataService.instance.getAllRankingFor(userId: userId, friendsAllay: friendsAllay, favoritesAllay: favoritsAllay) { (returnRanking) in
            self.rankingArray = returnRanking
            
            // Test -> Succeeded.
            print(self.rankingArray[0].title)
            print(self.rankingArray[1].title)
            print(self.rankingArray[2].title)
            
            // Test -> Succeeded.
            self.tableView.reloadData()
        }
        
        DataService.instance.getAllRankItemsFor(rankingKey: rankingKey) { (returnedRankItem) in
            self.rankItemsArray = returnedRankItem
        }
        
        self.tableView.reloadData()
    }
    
    
}

extension AllRankVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return numberOfRowInTableView
        return rankingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allRankingItemCell", for: indexPath) as? AllRankingItemCell else {
            print("Fail to get allRankingItemCell")
            return UITableViewCell()
        }
        
//        print("HERE IS A PRINT TEST !!!")
//        print(rankingTitle)
        
//        print(rankItem.title)

//        cell.configureCell(rank: 1, title: rankingTitle, itemImage: "1", explanation: "1")
        
        let rankNumber: [Int] = []
        let rankItemName: [String] = []
        let rankItemImage: [String] = []
        
        DataService.instance.getUsername(forUID: rankingArray[indexPath.row].userId) { (nameOfRankingOwner) in
            cell.configureCell(title: self.rankingArray[indexPath.row].title, nameOfRankingOwner: nameOfRankingOwner, dateRankingWasCreated: self.rankingArray[indexPath.row].date, profileOfOwner: "1", fried: "1", rankNumber: rankNumber, rankItemName: rankItemName, rankItemImage: rankItemImage)
//            tableView.reloadData()
        }
        

        
//        cell.configureCell(rank: 1, title: rankingArray[indexPath.row].title, itemImage: "1", explanation: "1")
        
        // This Worked
//        cell.configureCell(rank: 1, title: rankItemsArray[indexPath.row].title, itemImage: "1", explanation: "1")
        
        // Test Succeeded
//        cell.configureCell(rank: 1, title: rankingKey, itemImage: "1", explanation: "1")
        // Test Succeeded
//        cell.configureCell(rank: 1, title: "How about this", itemImage: "1", explanation: "1")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EachRankVC", sender: nil)
    }
}
