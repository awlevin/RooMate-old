//
//  RMGroup.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 26/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMGroup {
    var groupID: String // Also known as unique identifier
    var dateCreatedAt: String
    var dateUpdatedAt: String
    //var communalGroceryLists: [RMGroceryList]
    //var aggregateGroceryLists: [RMGroceryList]
    //var choresList: [RMChore]
    
    public static func leaveHousehold() {
        //Call the backend to delete you from the household and then signout
    }
    
    public static func createHousehold() -> String? {
        //Call the backend to make a new UUID for a group, and add this user to
        //the household automatically
        return nil
    }
    
    public static func joinHousehold(groupId: Int) {
        //Call the backend to add the current user to the household, and on
        //success, actually log them in.
    }
    
    public static func doesGroupExist(groupID: Int, completion: (groupExists: Bool)->() ) {
        
    }
}
