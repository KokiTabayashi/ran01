//
//  DataService.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/23.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_RANKING = DB_BASE.child("ranking")
    private var _REF_ITEMS = DB_BASE.child("items")
    private var _REF_COMMENTS = DB_BASE.child("comments")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_RANKING: DatabaseReference {
        return _REF_RANKING
    }
    
    var REF_ITEMS: DatabaseReference {
        return _REF_ITEMS
    }
    
    var REF_COMMENTS: DatabaseReference {
        return _REF_COMMENTS
    }
    
    func getCurrentUserId() -> String {
        var userId: String = ""
        if let Id = Auth.auth().currentUser?.uid {
            userId = Id
        }
        return userId
    }
    
    
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUserID(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "username").value as! String)
                }
            }
        }
    }
    
    func registerRanking(withTitle title: String, userId: String, numberOfItems: Int, registerRankingComplete: @escaping (_ status: Bool, _ key: String) -> ()) {
        
        let dateAndTime = TimeService.instance.getDateAndTime()
        let rankingKey = REF_RANKING.childByAutoId().key
        let rankingInfo = ["title": title, "userId": userId, "dateAndTime": dateAndTime, "numberOfItems": numberOfItems] as [String : Any]
        let childUpdates = ["/ranking/\(rankingKey)": rankingInfo]
        
        DB_BASE.updateChildValues(childUpdates)
        
        registerRankingComplete(true, rankingKey)
    }
    
    
    func getRankingTitle(forRankingKey key: String, handler: @escaping (_ rankingTitle: String) -> ()) {
        REF_RANKING.observeSingleEvent(of: .value) { (rankingSnapshot) in
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for ranking in rankingSnapshot {
                if ranking.key == key {
                    handler(ranking.childSnapshot(forPath: "title").value as! String)
                }
            }
        }
    }
    
    func getNumberOfItems(forRankingKey key: String, handler: @escaping (_ numberOfItems: Int) -> ()) {
        REF_RANKING.observeSingleEvent(of: .value) { (numberOfItemsSnapshot) in
            guard let numberOfItemsSnapshot = numberOfItemsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for numberOfItems in numberOfItemsSnapshot {
                if numberOfItems.key == key {
                    handler(numberOfItems.childSnapshot(forPath: "numberOfItems").value as! Int)
                }
            }
        }
    }
    
    func addRankingItemDetail(withRank rank: Int, title: String, explanation: String, image: String, withRankingKey rankingKey: String, addDetailComplete: @escaping (_ status: Bool) -> ()) {
        
        REF_ITEMS.child(rankingKey).childByAutoId().updateChildValues(["rank": rank, "title": title, "explanation": explanation, "image": image])
        addDetailComplete(true)

    }
    
    func getAllRankingFor(userId: String, friendsAllay: [String]?, favoritesAllay: [String]?, handler: @escaping (_ rankingArray: [Ranking]) -> ()) {
        var rankingArray = [Ranking]()
        
        REF_RANKING.observeSingleEvent(of: .value) { (rankingSnapshot) in
            
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for ranking in rankingSnapshot {
                let rankingKey = ranking.key

                let title = ranking.childSnapshot(forPath: "title").value as! String
                let userId = ranking.childSnapshot(forPath: "userId").value as! String
                let date = ranking.childSnapshot(forPath: "dateAndTime").value as! String
                let explanation: String = ""
                let itemsId: [String] = []
                let starsId: [String] = []
                let commentsId: [String] = []
                
                let ranking = Ranking(rankingKey: rankingKey, title: title, userId: userId, date: date, explanation: explanation, itemsId: itemsId, starsId: starsId, commentsId: commentsId)
                
                rankingArray.append(ranking)
            }
            handler(rankingArray)
        }
    }
    
    
    
    
    func getAllRankItemsFor(rankingKey: String, handler: @escaping (_ rankingItemsArray: [RankItem]) -> ()) {
        
        var rankingItemsArray = [RankItem]()
        
        REF_ITEMS.child(rankingKey).observeSingleEvent(of: .value) { (rankingItemsSnapshot) in
            
            guard let rankingItemsSnapshot = rankingItemsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let stars: [String] = []
            
            for rankingItem in rankingItemsSnapshot {
                let rank = rankingItem.childSnapshot(forPath: "rank").value as! Int
                let title = rankingItem.childSnapshot(forPath: "title").value as! String
                let image = rankingItem.childSnapshot(forPath: "image").value as! String
                let explanation = rankingItem.childSnapshot(forPath: "explanation").value as! String
                // Need to think about solution here. Just commented out for now.
//                let stars = rankingItem.childSnapshot(forPath: "stars").value as! [String]
                let rankItem = RankItem(rank: rank, title: title, image: image, explanation: explanation, stars: stars)
                rankingItemsArray.append(rankItem)
            }
            handler(rankingItemsArray)
        }
    }
    
    

    
    
    
}
