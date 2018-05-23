//
//  DataService.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let properties = [
    Property(propertyItem: "Me"),
    Property(propertyItem: "Logout")
    ]
    
    func getProperties() -> [Property] {
        return properties
    }
    
    
    
}
