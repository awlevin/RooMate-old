//
//  RMUser.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMUser: Hashable {
    var userObjectId: String
    var groupId: String
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var firstName: String
    var email: String
    var profileImageURL: String
    var userGroceryLists: [RMGroceryList]
    
    // TODO: Ritvik double check this. This is my attempt at making RMUser conform to Hashable.
    // We needed an appropriate hashValue, so I figured the uniqueness of userObjectId would produce a good hash value.
    public var hashValue: Int { return userObjectId.hashValue }
    
    
    // Public Functions
    /*
    public func createUser(user: RMUser) -> String? {
        
    }
     */
}



// Conform RMUser to the Equatable protocol, so then RMUser can conform to Hashable.
// Ultimately, RMUser must conform to Hashable to be used as a key in dictionaries.
extension RMUser: Equatable {}

public func ==(lhs: RMUser, rhs: RMUser) -> Bool {
    
    // Two users are equal if their objectIds are equivalent.
    return lhs.userObjectId == rhs.userObjectId
}





