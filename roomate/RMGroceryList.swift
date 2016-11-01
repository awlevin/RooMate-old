//
//  RMGroceryList.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMGroceryList {
    var objectId: String
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var groceryList: [RMGrocery]
    var isCommunal: Bool
    var isAggregate: Bool
    
    
    
    // Public Functions
    
    public func getCurrentUserGroceryList(userObjectId: String) -> RMGroceryList {
    
    }
    
    public func getPastUserGroceryList(offset: Int, count: Int) -> [RMGroceryList] {
        
    }
    
    public func getAggregateGroceries(groupId: String) -> RMGroceryList{
        
    }
    
    public func deleteCurrentUserGroceryList(userObjectId: String) {
    
    }
    
    public func addToUserGroceryList(groupId: String, newItem: RMGrocery) -> RMGroceryList {
    
    }
    
    public func getCommunalGroceries(groupId: String) -> RMGroceryList {
    
    }
    
    public func addToCommunalGroceryList(groupId: String, newItem: RMGrocery) -> RMGroceryList {
        
    }
    
    public func deleteCommunalGroceryList(groupId: String) {
        
    }
    
    public func addToAggregateGroceryList(groupId: String, newItem: RMGrocery) -> RMGroceryList {
        
    }
    
    public func finishedGroceryList(groupId: String) {
    
    }
    
    
    // Private Functions
    
    private func changeLastUpdateDate() {
        
    }
    
    private func compileAggregateGroceryList(groupId: String) -> [RMGroceryList] {
        
    }
    
    
    
    
    
}
