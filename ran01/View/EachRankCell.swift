//
//  EachRankCell.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/28.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class EachRankCell: UITableViewCell {
    
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var explanationLbl: UILabel!
    @IBOutlet weak var numberOfStarsLbl: UILabel!
    
    func configureCell(rank: Int, title: String, itemImage: String, explanation: String) {
        self.rankLbl.text = "\(rank)"
        self.itemNameLbl.text = title
//        self.itemImage.image =
        self.explanationLbl.text = explanation
    }
    
    @IBAction func starBtnWasPressed(_ sender: Any) {
    }
    
}
