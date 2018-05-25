//
//  TimeService.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/24.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation
import Firebase

class TimeService {
    static let instance = TimeService()
    
    let dateFormatter = DateFormatter()
    
    func getDateAndTime() -> String {
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "ja_JP")
        
        let registeredDate = Date()
        let dateAndTime: String = dateFormatter.string(from: registeredDate)
        
        return dateAndTime
    }
    
    
    func getAddUserDate() -> String {
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ja_JP")
        
        if let userCreatedDate = Auth.auth().currentUser?.metadata.creationDate {
            return dateFormatter.string(from: userCreatedDate)
        }
        
        return "-"
    }
}
