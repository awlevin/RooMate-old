//
//  RMGroceryList.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

enum RMGroceryListTypes {
    case Personal
    case Communal
    case Aggregate
}

public struct RMGroceryList {
    var objectId: Int
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var groceryList: [RMGrocery]
    var isCommunal: Bool
    var isAggregate: Bool
    
    // Public Functions
    
    static func getListByType(user: RMUser, listType: RMGroceryListTypes, completionHandler: (success: Bool, groceries: [RMGrocery]?)->()) {
        var postFix: String
        var requestParam: [String:String]
        
        switch listType {
        case .Personal:
            postFix = "selectRMUserGroceries"
            requestParam = ["userid" :"\(user.userObjectID)"]
        case .Communal:
            postFix = "selectRMCommunalGroceries"
            requestParam = ["groupid":"\(user.groupID)"]
        case .Aggregate:
            postFix = "selectRMCommunalGroceries"
            requestParam = ["groupid":"\(user.groupID)"]
        }
        
        RMQueryBackend.get("https://damp-plateau-63440.herokuapp.com/\(postFix)", parameters: requestParam) { (success, jsonResponse) in
            
            if success {
                completionHandler(success: true, groceries: RMGroceryList.createRMGroceryListFromJSON(jsonResponse))
            } else {
                completionHandler(success: false, groceries: nil) }
        }
    }
    
    static func createRMGroceryListFromJSON(jsonObject: NSArray?) -> [RMGrocery]{
        var groceryList = [RMGrocery]()
        
        for jsonItem in jsonObject! {
            let itemID = jsonItem["itemid"] as! Int
            let userID = jsonItem["userid"] as! Int
            let groupID = jsonItem["groupid"] as! Int
            let personalItem = jsonItem["personalitem"] as! Bool
            let groceryItemName = jsonItem["groceryitemname"] as! String
            let groceryItemPrice = jsonItem["groceryitemprice"] as! Double
            let groceryItemDescription = jsonItem["groceryitemdescription"] as! String
            let quantity = jsonItem["quantity"] as! Int
            let listID = jsonItem["listid"] as? Int
            
            groceryList.append(RMGrocery(objectID: itemID, userID: userID, groupID: groupID, isPersonalItem: personalItem, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: groceryItemName, groceryItemPrice: groceryItemPrice, groceryItemDescription: groceryItemDescription, quantity: quantity, listID: listID))
        }
        
        return groceryList
    }
}
