//
//  PropertyService.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/24.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation

class PropertyService {
    static let instance = PropertyService()
    
    private let properties = [
        Property(propertyItem: "Me"),
        Property(propertyItem: "Find Friends"),
        Property(propertyItem: "Logout")
    ]
    
    func getProperties() -> [Property] {
        return properties
    }
}
