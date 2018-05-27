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
    
//    func configureCell(title: String, nameOfRankingOwner: String, dateRankingWasCreated: String, profileOfOwner: String, fried: String, rankItemDetail: [RankItem]) {
    func configureCell(title: String, nameOfRankingOwner: String, dateRankingWasCreated: String, profileOfOwner: String, fried: String, rankItemDetail: [Int : RankItem]) {
    
        titleOfRankingLbl.text = title
        nameOfRankingOwnerLbl.text = nameOfRankingOwner
        dateRankingWasCreatedLbl.text = dateRankingWasCreated
        
        
        if let rank = rankItemDetail[0]?.rank {
            firstRankNumberLbl.text = "\(rank)"
        } else {
            firstRankNumberLbl.text = "-"
        }
        if let rank = rankItemDetail[1]?.rank {
            secondRankNumberLbl.text = "\(rank)"
        } else {
            secondRankNumberLbl.text = "-"
        }
        if let rank = rankItemDetail[2]?.rank {
            thirdRankNumberLbl.text = "\(rank)"
        } else {
            thirdRankNumberLbl.text = "-"
        }
        
        
//        if rankItemDetail.count > 0 {
//            firstRankNumberLbl.text = "\(rankItemDetail[0].rank)"
//
//            if rankItemDetail.count > 1 {
//                secondRankNumberLbl.text = "\(rankItemDetail[1].rank)"
//
//                if rankItemDetail.count > 2 {
//                    thirdRankNumberLbl.text = "\(rankItemDetail[2].rank)"
//                }
//            }
//        }
        
        
        if rankItemDetail.count > 0 {
            if rankItemDetail[0]?.title != "" {
                firstRankItemNameLbl.text = rankItemDetail[0]?.title
            } else {
                firstRankItemNameLbl.text = "-"
            }
            
            if rankItemDetail.count > 1 {
                if rankItemDetail[1]?.title != "" {
                    secondRankItemNameLbl.text = rankItemDetail[1]?.title
                } else {
                    secondRankItemNameLbl.text = "-"
                }
                if rankItemDetail.count > 2 {
                    if rankItemDetail[2]?.title != "" {
                        thirdRankItemNameLbl.text = rankItemDetail[2]?.title
                    } else {
                        thirdRankItemNameLbl.text = "-"
                    }
                }
            }
        }
        
        
        
        
        
//        if rankItemDetail.count > 0 {
//            if rankItemDetail[0].title != "" {
//                firstRankItemNameLbl.text = rankItemDetail[0].title
//            } else {
//                firstRankItemNameLbl.text = "-"
//            }
//
//            if rankItemDetail.count > 1 {
//                if rankItemDetail[1].title != "" {
//                    secondRankItemNameLbl.text = rankItemDetail[1].title
//                } else {
//                    secondRankItemNameLbl.text = "-"
//                }
//                if rankItemDetail.count > 2 {
//                    if rankItemDetail[2].title != "" {
//                        thirdRankItemNameLbl.text = rankItemDetail[2].title
//                    } else {
//                        thirdRankItemNameLbl.text = "-"
//                    }
//                }
//            }
//        }
    }
}