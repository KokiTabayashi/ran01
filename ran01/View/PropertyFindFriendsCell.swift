//
//  PropertyFindFriendsCell.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/31.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class PropertyFindFriendsCell: UITableViewCell {

    @IBOutlet weak var friendProfileImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
    func configureCell(friendName: String) {
        self.friendName.text = friendName
    }
}