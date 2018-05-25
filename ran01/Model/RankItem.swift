//
//  RankItem.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/24.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation

class RankItem {
    private var _rank: Int
    private var _title: String
    private var _image: String
    private var _explanation: String
    private var _stars: [String]
    
    var rank: Int {
        return _rank
    }
    
    var title: String {
        return _title
    }
    
    var image: String {
        return _image
    }
    
    var explanation: String {
        return _explanation
    }
    
    var stars: [String] {
        return _stars
    }
    
    init(rank: Int, title: String, image: String, explanation: String, stars: [String]) {
        self._rank = rank
        self._title = title
        self._image = image
        self._explanation = explanation
        self._stars = stars
    }
}
