//
//  RMGrocery.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMGrocery {
    var objectId: String
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var groceryItemName: String
    var groceryItemPrice: Double
    var groceryItemDescription: String
    
    
    // Public Functions
    
    public func getGrocery(listId: String, objectId: String) -> RMGrocery {
        
    }
    
    public func deleteGrocery(listId: String, objectId: String) {
        
    }
    
    public func editGrocery(groceryItem: RMGrocery) -> RMGrocery {
        
    }
    
    
    // Private Functions
    
    private func changeLastUpdateDate() {
        
    }
    
    private func changeCommunalState() {
        
    }
}
