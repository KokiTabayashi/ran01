//
//  Property.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation

struct Property {
    private(set) public var propertyItem: String
    
    init(propertyItem: String) {
        self.propertyItem = propertyItem
    }
}
