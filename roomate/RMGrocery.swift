//
//  RMGrocery.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMGrocery {
    var objectID: Int
    var userID: Int
    var groupID: Int
    var isPersonalItem: Bool
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var groceryItemName: String
    var groceryItemPrice: Double
    var groceryItemDescription: String
    var quantity: Int
    var listID: Int?
    
    
    static func createNewGrocery(grocery: RMGrocery, completionHandler: (completed: Bool) -> ()) {
        
        let newGroceryDict = RMGrocery.createGroceryDictionary(grocery)
        
        RMQueryBackend.post("https://damp-plateau-63440.herokuapp.com/createRMGrocery", params: newGroceryDict) { (succeeded, jsonResponse) in
            (succeeded) ? completionHandler(completed: true) : completionHandler(completed: false)
        }
    }
    
    /*static func createNewGrocery(grocery: RMGrocery, completionHandler: (completed: Bool)->()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/createRMGrocery"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        let groceryDictionary = RMGrocery.createGroceryDictionary(grocery)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(groceryDictionary, options: [.PrettyPrinted])
            print("**********************")
            print(NSString(data: request.HTTPBody!, encoding:NSUTF8StringEncoding)!)
        } catch let error as NSError {
            print(error)
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                switch statusCode {
                case 400:
                    print("Error Encountered: 400")
                    completionHandler(completed: false)
                    break
                case 503:
                    print("Error Encountered: 503")
                    completionHandler(completed: false)
                    break
                default:
                    print("Encountered error: \(statusCode)")
                    completionHandler(completed: false)
                    break
                }
                return
            } else {
                // let json = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            }
        }
        task.resume()
        completionHandler(completed: true)
    }*/
    
    static func editGrocery(grocery: RMGrocery, completionHandler: (completed: Bool)->() ) {
        let editedGroceryDict = RMGrocery.editGroceryDictionary(grocery)
        
        RMQueryBackend.post("https://damp-plateau-63440.herokuapp.com/editRMGrocery", params: editedGroceryDict) { (succeeded, jsonResponse) in
            (succeeded) ? completionHandler(completed: true) : completionHandler(completed: false)
        }
    }
    
    static func deleteGrocery(grocery: RMGrocery, completionHandler: (completed: Bool)->() ) {
        RMQueryBackend.post("https://damp-plateau-63440.herokuapp.com/deleteRMGrocery", params: RMGrocery.deleteGroceryDictionary(grocery)) { (succeeded, jsonResponse) in
            (succeeded) ? completionHandler(completed: true) : completionHandler(completed: false)
        }
    }
    
    
    // MARK: Dictionaries
    
    static func createGroceryDictionary(groceryObject: RMGrocery) -> [String : AnyObject] {
        
        var returnDict = [String : AnyObject]()
        
        returnDict["userid"] = groceryObject.userID
        returnDict["groupid"] = groceryObject.groupID
        returnDict["personalitem"] = (groceryObject.isPersonalItem) ? "TRUE" : "FALSE"
        returnDict["groceryitemname"] = groceryObject.groceryItemName
        returnDict["groceryitemprice"] = groceryObject.groceryItemPrice
        returnDict["quantity"] = groceryObject.quantity
        returnDict["groceryitemdescription"] = groceryObject.groceryItemDescription

        return returnDict
    }
    
    static func editGroceryDictionary(groceryObject: RMGrocery) -> [String : AnyObject] {
        var dict = [String : AnyObject]()
        
        dict["userid"] = groceryObject.userID
        dict["groupid"] = groceryObject.groupID
        dict["personalitem"] = (groceryObject.isPersonalItem) ? "TRUE" : "FALSE"
        dict["groceryitemname"] = groceryObject.groceryItemName
        dict["groceryitemprice"] = groceryObject.groceryItemPrice
        dict["quantity"] = groceryObject.quantity
        dict["groceryitemdescription"] = groceryObject.groceryItemDescription
        dict["listid"] = groceryObject.listID
        dict["itemid"] = groceryObject.objectID
        
        return dict
    }
    
    static func deleteGroceryDictionary(groceryObject: RMGrocery) -> [String : AnyObject] {
        var returnDict = [String : AnyObject]()
        
        returnDict["userid"] = groceryObject.userID
        returnDict["groupid"] = groceryObject.groupID
        returnDict["itemid"] = groceryObject.objectID
        
        return returnDict
    }
}
