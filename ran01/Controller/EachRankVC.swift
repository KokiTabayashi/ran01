//
//  EachRankVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/21.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class EachRankVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var rankingExplanationLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfStarsLbl: UILabel!
    
    @IBOutlet weak var numberOfFavorites: UIButton!
    @IBOutlet weak var numberOfCommentsLbl: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var rankingKey: String = ""
    var rankingTitle: String = ""
    var username: String = ""
    var rankItemsArray: [RankItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataService.instance.getRankingInfo(forRankingKey: rankingKey) { (returnedRankingTitle, returnedUserId, returnedNumberOfItems, returnedCreatedDate) in
            self.rankingTitle = returnedRankingTitle
            DataService.instance.getUsername(forUID: returnedUserId, handler: { (returnedUsername) in
                self.username = returnedUsername
                
                self.titleLbl.text = returnedRankingTitle
                self.usernameLbl.text = returnedUsername
                self.createdDateLbl.text = returnedCreatedDate
                self.rankingExplanationLbl.text = "-"
                
                self.tableView.reloadData()
            })
        }
        
        DataService.instance.getAllRankItemsFor(rankingKey: rankingKey) { (returnedRankItem) in
            self.rankItemsArray = returnedRankItem
            self.rankItemsArray.sort(by: {$0.rank < $1.rank})
            self.tableView.reloadData()
        }
        
        _showFavoriteButton(rankingKey: rankingKey)
    }
    
    func _showFavoriteButton(rankingKey key: String) {
        
        //
        // Coding
        // 2018/8/10
        //
        
        DataService.instance.isFavorite(withFavoriteRankingKey: key) { (isFavoriteResult) in
            let isFavorite = isFavoriteResult
            
            if isFavorite {
                self.favoriteBtn.isHidden = true
            } else {
                self.favoriteBtn.isHidden = false
            }
        }
    }
    
    func _setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func starBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func favoriteBtnWasPressed(_ sender: Any) {
        DataService.instance.addFavoriteRanking(withRankingKey: rankingKey) { (success) in
            
        }
    }
    
    @IBAction func commentBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension EachRankVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eachRankCell") as? EachRankCell else { return UITableViewCell() }
        
        cell.configureCell(rank: rankItemsArray[indexPath.row].rank, title: rankItemsArray[indexPath.row].title, itemImage: "-", explanation: "-")
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "<#SegueToViewController#>", sender: nil)
//    }
}
