//
//  Ranking.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/24.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation

class Ranking {
    private var _title: String
    private var _userId: String
    private var _date: String
    private var _explanation: String
    private var _itemsId: [String]
    private var _starsId: [String]
    private var _commentsId: [String]
    
    var title: String {
        return _title
    }
    
    var userId: String {
        return _userId
    }
    
    var date: String {
        return _date
    }
    
    var explanation: String {
        return explanation
    }
    
    var itemsId: [String] {
        return _itemsId
    }
    
    var starsId: [String] {
        return _starsId
    }
    
    var commentsId: [String] {
        return _commentsId
    }
    
    init(title: String, userId: String, date: String, explanation: String, itemsId: [String], starsId: [String], commentsId: [String]) {
        self._title = title
        self._userId = userId
        self._date = date
        self._explanation = explanation
        self._itemsId = itemsId
        self._starsId = starsId
        self._commentsId = commentsId
    }
}
