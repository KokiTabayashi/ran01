//
//  Friend.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/06/01.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation

class Friend {
    private var _userId: String
    private var _userName: String
    
    var userId: String {
        return _userId
    }
    
    var userName: String {
        return _userName
    }
    
    init(userId: String, userName: String) {
        self._userId = userId
        self._userName = userName
    }
}
