//
//  FollowerMemberCell.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/06/02.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class FollowerMemberCell: UITableViewCell {

    @IBOutlet weak var friendProfileImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
    func configureCell(friendName: String) {
        self.friendName.text = friendName
    }
}
