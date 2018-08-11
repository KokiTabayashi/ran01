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
    private var _REF_RANKING_TMP = DB_BASE.child("rankingTmp")
    private var _REF_ITEMS = DB_BASE.child("items")
    private var _REF_ITEMS_TMP = DB_BASE.child("itemsTmp")
    private var _REF_COMMENTS = DB_BASE.child("comments")
    private var _REF_FRIENDS = DB_BASE.child("friends")
    private var _REF_FOLLOWER = DB_BASE.child("follower")
    private var _REF_FAVORITE = DB_BASE.child("favorite")
    private var _REF_FAVORITEDBY = DB_BASE.child("favoritedBy")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_RANKING: DatabaseReference {
        return _REF_RANKING
    }
    
    var REF_RANKING_TMP: DatabaseReference {
        return _REF_RANKING_TMP
    }
    
    var REF_ITEMS: DatabaseReference {
        return _REF_ITEMS
    }
    
    var REF_ITEMS_TMP: DatabaseReference {
        return _REF_ITEMS_TMP
    }
    
    var REF_COMMENTS: DatabaseReference {
        return _REF_COMMENTS
    }
    
    var REF_FRIENDS: DatabaseReference {
        return _REF_FRIENDS
    }
    
    var REF_FOLLOWER: DatabaseReference {
        return _REF_FOLLOWER
    }
    
    var REF_FAVORITE: DatabaseReference {
        return _REF_FAVORITE
    }
    
    var REF_FAVORITEDBY: DatabaseReference {
        return _REF_FAVORITEDBY
    }
    
    
    //
    // User function
    //
    
    func getCurrentUserId(handler: @escaping (_ userId: String) -> ()) {
        guard let userId: String = Auth.auth().currentUser?.uid else { return }
        handler(userId)
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
    
    
    //
    // Friends
    //
    
    func findFriends(withName name: String, handler: @escaping (_ friendsArray: [Friend]) -> ()) {
        var friendsArray = [Friend]()
        
        REF_USERS.queryOrderedByKey().observeSingleEvent(of: .value) { (friendsSnapshot) in
            
            guard let friendsSnapshot = friendsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for friend in friendsSnapshot {
                let friendUserId = friend.key
                let friendName = friend.childSnapshot(forPath: "username").value as! String

                if friendName.contains(name) {
                    let friendInfo = Friend(userId: friendUserId, userName: friendName)
                    friendsArray.append(friendInfo)
                }
            }
            handler(friendsArray)
        }
    }
    
    func isFriends(withName name: String, handler: @escaping (_ status: Bool) -> ()) {
        REF_USERS.queryOrderedByKey().observeSingleEvent(of: .value) { (friendsSnapshot) in
            guard let friendSnapshot = friendsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for friend in friendSnapshot {
                let friendName = friend.childSnapshot(forPath: "username").value as! String
                
                if friendName == name {
                    handler(true)
                } else {
                    handler(false)
                }
            }
        }
    }
    
    func addFriend(friendsUserId: String, handler: @escaping (_ status: Bool) -> ()) {
        getCurrentUserId { (userId) in
            // add follow
            self.REF_FRIENDS.child(userId).childByAutoId().updateChildValues(["friendsUserId": friendsUserId])
            
            // add follower
            self.REF_FOLLOWER.child(friendsUserId).childByAutoId().updateChildValues(["followerUserId": userId])
        }
    }
    
    
    func getAllFollowUserFor(userId: String, handler: @escaping (_ followUserIdArray: [String]) -> ()) {
        
        var followUserIdArray = [String]()
        
        REF_FRIENDS.child(userId).observeSingleEvent(of: .value) { (friendsSnapshot) in
            
            guard let friendsSnapshot = friendsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for friend in friendsSnapshot {
                let userId = friend.childSnapshot(forPath: "friendsUserId").value as! String
                followUserIdArray.append(userId)
            }
            handler(followUserIdArray)
        }
    }
    
    
    func getAllFollowerFor(userId: String, handler: @escaping (_ friendsUserIdArray: [String]) -> ()) {
        
        var followerUserIdArray = [String]()
        
        REF_FOLLOWER.child(userId).observeSingleEvent(of: .value) { (followersSnapshot) in
            
            guard let followersSnapshot = followersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for follower in followersSnapshot {
                let userId = follower.childSnapshot(forPath: "followerUserId").value as! String
                followerUserIdArray.append(userId)
            }
            handler(followerUserIdArray)
        }
    }
    
    
    
    //
    // Ranking Function
    //
    
    func registerRanking(withTitle title: String, userId: String, numberOfItems: Int, registerRankingComplete: @escaping (_ status: Bool, _ key: String) -> ()) {

        let dateAndTime = TimeService.instance.getDateAndTime()
        let rankingKey = REF_RANKING.childByAutoId().key
        let rankingInfo = ["title": title, "userId": userId, "dateAndTime": dateAndTime, "numberOfItems": numberOfItems] as [String : Any]
        let childUpdates = ["/ranking/\(rankingKey)": rankingInfo]

        DB_BASE.updateChildValues(childUpdates)

        registerRankingComplete(true, rankingKey)
    }
    
    func registerRankingTmp(withTitle title: String, userId: String, numberOfItems: Int, registerRankingComplete: @escaping (_ status: Bool, _ key: String) -> ()) {
        
        let dateAndTime = TimeService.instance.getDateAndTime()
        let rankingKey = REF_RANKING_TMP.childByAutoId().key
        let rankingInfo = ["title": title, "userId": userId, "dateAndTime": dateAndTime, "numberOfItems": numberOfItems] as [String : Any]
        let childUpdates = ["/rankingTmp/\(rankingKey)": rankingInfo]
        
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
    
    func getRankingTitleTmp(forRankingKey key: String, handler: @escaping (_ rankingTitle: String) -> ()) {
        REF_RANKING_TMP.observeSingleEvent(of: .value) { (rankingSnapshot) in
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for ranking in rankingSnapshot {
                if ranking.key == key {
                    handler(ranking.childSnapshot(forPath: "title").value as! String)
                }
            }
        }
    }
    
    func getRankingInfo(forRankingKey key: String, handler: @escaping (_ rankingTitle: String, _ userId: String, _ numberOfItems: Int, _ createdDate: String) -> ()) {
        REF_RANKING.observeSingleEvent(of: .value) { (rankingSnapshot) in
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for ranking in rankingSnapshot {
                if ranking.key == key {
                    handler(ranking.childSnapshot(forPath: "title").value as! String, ranking.childSnapshot(forPath: "userId").value as! String, ranking.childSnapshot(forPath: "numberOfItems").value as! Int, ranking.childSnapshot(forPath: "dateAndTime").value as! String)
                }
            }
        }
    }
    
    func getRankingInfoTmp(forRankingKey key: String, handler: @escaping (_ rankingTitle: String, _ userId: String, _ numberOfItems: Int) -> ()) {
        REF_RANKING_TMP.observeSingleEvent(of: .value) { (rankingSnapshot) in
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for ranking in rankingSnapshot {
                if ranking.key == key {
                    handler(ranking.childSnapshot(forPath: "title").value as! String, ranking.childSnapshot(forPath: "userId").value as! String, ranking.childSnapshot(forPath: "numberOfItems").value as! Int)
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
    
    func getNumberOfItemsTmp(forRankingKey key: String, handler: @escaping (_ numberOfItems: Int) -> ()) {
        REF_RANKING_TMP.observeSingleEvent(of: .value) { (numberOfItemsSnapshot) in
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
    
    func addRankingItemDetailTmp(withRank rank: Int, title: String, explanation: String, image: String, withRankingKey rankingKey: String, addDetailComplete: @escaping (_ status: Bool) -> ()) {
        
        REF_ITEMS_TMP.child(rankingKey).childByAutoId().updateChildValues(["rank": rank, "title": title, "explanation": explanation, "image": image])
        addDetailComplete(true)
    }
    
    func getAllRankingFor(userId: String, friendsAllay: [String]?, favoritesAllay: [String]?, handler: @escaping (_ rankingArray: [Ranking]) -> ()) {
        var rankingArray = [Ranking]()
        
        REF_RANKING.observeSingleEvent(of: .value) { (rankingSnapshot) in
            
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for ranking in rankingSnapshot {
                // getting ranking Key
                let rankingKey = ranking.key

                let title = ranking.childSnapshot(forPath: "title").value as! String
                let rankingUserId = ranking.childSnapshot(forPath: "userId").value as! String
                let date = ranking.childSnapshot(forPath: "dateAndTime").value as! String
                let explanation: String = ""
                let itemsId: [String] = []
                let starsId: [String] = []
                let commentsId: [String] = []
                
                let ranking = Ranking(rankingKey: rankingKey, title: title, userId: rankingUserId, date: date, explanation: explanation, itemsId: itemsId, starsId: starsId, commentsId: commentsId)
                
                rankingArray.append(ranking)
            }
            handler(rankingArray)
        }
    }
    
    func getAllRankingForUser(userId: String, handler: @escaping (_ rankingArray: [Ranking]) -> ()) {
        var rankingArray = [Ranking]()
        
        REF_RANKING.observeSingleEvent(of: .value) { (rankingSnapshot) in
            
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for ranking in rankingSnapshot {
                // getting ranking Key
                let rankingKey = ranking.key
                
                let title = ranking.childSnapshot(forPath: "title").value as! String
                let rankingUserId = ranking.childSnapshot(forPath: "userId").value as! String
                let date = ranking.childSnapshot(forPath: "dateAndTime").value as! String
                let explanation: String = ""
                let itemsId: [String] = []
                let starsId: [String] = []
                let commentsId: [String] = []
                
                let ranking = Ranking(rankingKey: rankingKey, title: title, userId: rankingUserId, date: date, explanation: explanation, itemsId: itemsId, starsId: starsId, commentsId: commentsId)
                
                if userId == rankingUserId {
                    rankingArray.append(ranking)
                }
            }
            handler(rankingArray)
        }
    }
    
    
    
    // Favorite
    func addFavoriteRanking(withRankingKey rankingKey: String, handler: @escaping (_ status: Bool) -> ()) {
        
        //
        // Coded. Need add a "Favorite" button on MainStoryBoard which only shows up if the ranking is not yours.
        //
        
        getCurrentUserId { (userId) in
            // add follow
            self.REF_FAVORITE.child(userId).childByAutoId().updateChildValues(["favoriteRankingKey": rankingKey])
            
            // add follower
            self.REF_FAVORITEDBY.child(rankingKey).childByAutoId().updateChildValues(["favoritedByUserId": userId])
        }
    }
    
    func isFavorite(withFavoriteRankingKey key: String, handler: @escaping (_ status: Bool) -> ()) {
        
        //
        // Need to change code?
        // 2018/8/10
        // Original isFriends
        //
        
        getCurrentUserId { (userId) in
            self.REF_FAVORITE.child(userId).queryOrderedByKey().observeSingleEvent(of: .value) { (favoritesSnapshot) in
                guard let favoritesSnapshot = favoritesSnapshot.children.allObjects as? [DataSnapshot] else { return }
                
                for favorite in favoritesSnapshot {
                    let favoriteRankingKey = favorite.childSnapshot(forPath: "favoriteRankingKey").value as! String
                    
                    if favoriteRankingKey == key {
                        handler(true)
                    } else {
                        handler(false)
                    }
                }
            }
        }
    }
    
//    func getAllFavoriteRankingForUser(userId: String, handler: @escaping (_ rankingArray: [Ranking]) -> ()) {
//
//        var rankingKeyArray = [String]()
//        var rankingArray = [Ranking]()
//
//        REF_FAVORITE.child(userId).observeSingleEvent(of: .value) { (favoriteRankingSnapshot) in
//
//            guard let favoriteRankingSnapshot = favoriteRankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
//
//            for ranking in favoriteRankingSnapshot {
//                let rankingKey = ranking.childSnapshot(forPath: "favoriteRankingKey").value as! String
//                rankingKeyArray.append(rankingKey)
//            }
//
//
//                let rankingKey = ranking.childSnapshot(forPath: "favoriteRankingKey").value as! String
//                let title: String = ""
//                let rankingUserId: String = ""
//                let date: String = ""
//                let explanation: String = ""
//                let itemsId: [String] = []
//                let starsId: [String] = []
//                let commentsId: [String] = []
//
//                let ranking = Ranking(rankingKey: rankingKey, title: title, userId: rankingUserId, date: date, explanation: explanation, itemsId: itemsId, starsId: starsId, commentsId: commentsId)
//
//                rankingArray.append(ranking)
//            }
//            handler(rankingArray)
//        }
//    }
    
    func getAllFavoriteRankingForUser(userId: String, handler: @escaping (_ rankingKeyArray: [String]) -> ()) {

        var rankingKeyArray = [String]()

        REF_FAVORITE.child(userId).observeSingleEvent(of: .value) { (favoriteRankingSnapshot) in

            guard let favoriteRankingSnapshot = favoriteRankingSnapshot.children.allObjects as? [DataSnapshot] else { return }

            for ranking in favoriteRankingSnapshot {
                let rankingKey = ranking.childSnapshot(forPath: "favoriteRankingKey").value as! String
                rankingKeyArray.append(rankingKey)
            }
            handler(rankingKeyArray)
        }
    }
    
    func getAllFavoriteRankingForRankingKey(rankingKeyArray: [String], handler: @escaping (_ rankingArray: [Ranking]) -> ()) {

        //
        // Coded 2018/8/10
        // Original: getAllRankingForUser
        //

        var rankingArray = [Ranking]()

        REF_RANKING.observeSingleEvent(of: .value) { (rankingSnapshot) in

            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }

            for ranking in rankingSnapshot {
                // getting ranking Key
                let rankingKey = ranking.key

                let title = ranking.childSnapshot(forPath: "title").value as! String
                let rankingUserId = ranking.childSnapshot(forPath: "userId").value as! String
                let date = ranking.childSnapshot(forPath: "dateAndTime").value as! String
                let explanation: String = ""
                let itemsId: [String] = []
                let starsId: [String] = []
                let commentsId: [String] = []

                let ranking = Ranking(rankingKey: rankingKey, title: title, userId: rankingUserId, date: date, explanation: explanation, itemsId: itemsId, starsId: starsId, commentsId: commentsId)
                for key in rankingKeyArray {
                    if key == rankingKey {
                        rankingArray.append(ranking)
                    }
                }
            }
            handler(rankingArray)
        }
    }
    
    
    func getAllRankingForFollowUser(followUserIdArray: [String], handler: @escaping (_ rankingArray: [Ranking]) -> ()) {
        var rankingArray = [Ranking]()
        
        REF_RANKING.observeSingleEvent(of: .value) { (rankingSnapshot) in
            
            guard let rankingSnapshot = rankingSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for ranking in rankingSnapshot {
                // getting ranking Key
                let rankingKey = ranking.key
                
                let title = ranking.childSnapshot(forPath: "title").value as! String
                let rankingUserId = ranking.childSnapshot(forPath: "userId").value as! String
                let date = ranking.childSnapshot(forPath: "dateAndTime").value as! String
                let explanation: String = ""
                let itemsId: [String] = []
                let starsId: [String] = []
                let commentsId: [String] = []
                
                let ranking = Ranking(rankingKey: rankingKey, title: title, userId: rankingUserId, date: date, explanation: explanation, itemsId: itemsId, starsId: starsId, commentsId: commentsId)
                
                if followUserIdArray.index(of: rankingUserId) != nil {
                    rankingArray.append(ranking)
                }
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
    
    func getAllRankItemsAndUsernameFor(rankingKey: String, uid: String, handler: @escaping (_ rankingItemsArray: [RankItem], _ username: String) -> ()) {
        
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
            
            
            self.REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
                guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for user in userSnapshot {
                    if user.key == uid {
                        handler(rankingItemsArray, user.childSnapshot(forPath: "username").value as! String)
                    }
                }
            }
        }
    }
    
    func getAllRankItemsForTmp(rankingKey: String, handler: @escaping (_ rankingItemsArray: [RankItem]) -> ()) {
        
        var rankingItemsArray = [RankItem]()
        
        REF_ITEMS_TMP.child(rankingKey).observeSingleEvent(of: .value) { (rankingItemsSnapshot) in
            
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
