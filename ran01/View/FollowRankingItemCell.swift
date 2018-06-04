//
//  FollowRankingItemCell.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/06/03.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class FollowRankingItemCell: UITableViewCell {

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
  
    
    func configureCell(title: String, nameOfRankingOwner: String, dateRankingWasCreated: String, profileOfOwner: String, fried: String, rankItemDetail: [Int : RankItem]) {
        
        titleOfRankingLbl.text = title
        nameOfRankingOwnerLbl.text = nameOfRankingOwner
        dateRankingWasCreatedLbl.text = dateRankingWasCreated
        
        
        if let rank = rankItemDetail[0]?.rank {
            if rank == 0 {
                firstRankNumberLbl.text = "-"
            } else {
                firstRankNumberLbl.text = "\(rank)"
            }
        } else {
            firstRankNumberLbl.text = "-"
        }
        
        if let rank = rankItemDetail[1]?.rank {
            if rank == 0 {
                secondRankNumberLbl.text = "-"
            } else {
                secondRankNumberLbl.text = "\(rank)"
            }
        } else {
            secondRankNumberLbl.text = "-"
        }
        
        if let rank = rankItemDetail[2]?.rank {
            if rank == 0 {
                thirdRankNumberLbl.text = "-"
            } else {
                thirdRankNumberLbl.text = "\(rank)"
            }
        } else {
            thirdRankNumberLbl.text = "-"
        }
        
        
        
        if rankItemDetail.count > 2 {
            if rankItemDetail[0]?.title != "" {
                firstRankItemNameLbl.text = rankItemDetail[0]?.title
            } else {
                firstRankItemNameLbl.text = "-"
            }
            if rankItemDetail[1]?.title != "" {
                secondRankItemNameLbl.text = rankItemDetail[1]?.title
            } else {
                secondRankItemNameLbl.text = "-"
            }
            if rankItemDetail[2]?.title != "" {
                thirdRankItemNameLbl.text = rankItemDetail[2]?.title
            } else {
                thirdRankItemNameLbl.text = "-"
            }
        } else if rankItemDetail.count > 1 {
            if rankItemDetail[0]?.title != "" {
                firstRankItemNameLbl.text = rankItemDetail[0]?.title
            } else {
                firstRankItemNameLbl.text = "-"
            }
            if rankItemDetail[1]?.title != "" {
                secondRankItemNameLbl.text = rankItemDetail[1]?.title
            } else {
                secondRankItemNameLbl.text = "-"
            }
            thirdRankItemNameLbl.text = "-"
        } else if rankItemDetail.count > 0 {
            if rankItemDetail[0]?.title != "" {
                firstRankItemNameLbl.text = rankItemDetail[0]?.title
            } else {
                firstRankItemNameLbl.text = "-"
            }
            secondRankItemNameLbl.text = "-"
            thirdRankItemNameLbl.text = "-"
        }
    }
}
