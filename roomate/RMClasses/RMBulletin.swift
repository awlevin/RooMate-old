//
//  RMBulletin.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 26/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMBulletin {
    var objectId: String
    var dateCreatedAt: String
    var dateupdatedAt: String
    var posts: [RMBulletinPost]
    
    public func getPostWithId(postId: Int) -> RMBulletinPost?{
        for post in posts {
            if post.objectId == postId {
                return post;
            }
        }
        return nil;
    }
    
    public mutating func deletePostWithId(postId: Int)->Void{
        
        var delIndex = 0
        for post in posts {
            if post.objectId == postId {
                //Call the backend to dete the post
                let success = true
                if success {
                    posts.removeAtIndex(delIndex)
                    return
                }
            }
            delIndex += 1
        }
    }
}
