//
//  PropertyCell.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class PropertyCell: UITableViewCell {

    @IBOutlet weak var propertyLbl: UILabel!

    func updateViews(property: Property) {
        propertyLbl.text = property.propertyItem
    }
}
