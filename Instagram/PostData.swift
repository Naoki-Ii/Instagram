//
//  PostData.swift
//  Instagram
//
//  Created by NAOKI II on 2020/03/03.
//  Copyright © 2020 NAOKI.II. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    
    init(document: QueryDocumentSnapshot) {
        
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid{
            //likesの配列にmyidが含まれてるかチャックすることで、自分がいいねを押しているのか判断
            if self.likes.firstIndex(of: myid) != nil {
                //myidがあればいいねを押していると認識する
                self.isLiked = true
            }
        }
    }
}
