//
//  AllRankingItemCell.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/25.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class AllRankingItemCell: UITableViewCell {
    
    @IBOutlet weak var titleOfRankingLbl: UILabel!
    @IBOutlet weak var nameOfRankingOwnerLbl: UILabel!
    @IBOutlet weak var dateRankingWasCreatedLbl: UILabel!
    
    @IBOutlet weak var profileOfOwnerImage: UIImageView!
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var firstRankNumberLbl: UILabel!
    @IBOutlet weak var secondRankNumberLbl: UILabel!
    @IBOutlet weak var thirdRankNumberLbl: UILabel!

    @IBOutlet weak var firstRankItemNameLbl: UILabel!
    @IBOutlet weak var secondRankItemNameLbl: UILabel!
    @IBOutlet weak var thirdRankItemNameLbl: UILabel!
    
    @IBOutlet weak var firstRankItemImage: UIImageView!
    @IBOutlet weak var secondRankItemImage: UIImageView!
    @IBOutlet weak var thirdRankItemImage: UIImageView!
    
    func configureCell(title: String, nameOfRankingOwner: String, dateRankingWasCreated: String, profileOfOwner: String, fried: String, rankNumber: [Int], rankItemName: [String], rankItemImage: [String]) {
//        self.rankLbl.text = "\(rank)"
        
        titleOfRankingLbl.text = title
        nameOfRankingOwnerLbl.text = nameOfRankingOwner
        dateRankingWasCreatedLbl.text = dateRankingWasCreated
//        profileOfOwnerImage.image = profileOfOwner
//        friendImage.image = fried
        
//        firstRankNumberLbl.text = "\(rankNumber[0])"
//        secondRankNumberLbl.text = "\(rankNumber[1])"
//        thirdRankNumberLbl.text = "\(rankNumber[2])"
//        
//        firstRankItemNameLbl.text = rankItemName[0]
//        secondRankItemNameLbl.text = rankItemName[1]
//        thirdRankItemNameLbl.text = rankItemName[2]
        
//        firstRankItemImage.image = rankItemImage[0]
//        secondRankItemImage.image = rankItemImage[1]
//        thirdRankItemImage.image = rankItemImage[2]
        
        
        // Test Succeeded.
//        titleOfRankingLbl.text = "Test of configureCell"
        
        
        //        self.itemImage.image =
//        self.explanationLbl.text = explanation
    }
}
