//
//  RMChoreCompletion.swift
//  roomate
//
//  Created by Aaron Levin on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMChoreCompletion {
    var choreCompletionID: Int // unique objectID
    var choreID: Int // parent, actual RMChore objectID
    var personCompletedUserID: Int // userID of person who completed the chore
    var groupID: Int
    var title: String
    var additionalComments: String
    var beforePhotoURL: String
    var afterPhotoURL: String
    var dateCompleted: String
    
    
    
    static func createChoreCompletionDictionary(chore: RMChore, user: RMUser) -> [String : AnyObject]{
        var returnDict = [String : AnyObject]()
        returnDict["choreid"] = chore.choreID
        returnDict["userid"] = user.userObjectID
        returnDict["groupid"] = user.groupID
        returnDict["title"] = chore.title
        returnDict["description"] = chore.description
        return returnDict
    }
    
}
