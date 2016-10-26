//
//  RMBulletinPost.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 19/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMBulletinPost {
    var objectId: String
    var dateCreatedAt: String
    var dateupdatedAt: String
    var title: String
    var description: String
    var pinNote: Bool
    var photos: [String]
    var thumbnail: String
    var daysBeforeRemoval: Int
    var comments: [String: String]
}
