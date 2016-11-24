//
//  RMGrocery.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMGrocery {
    var objectId: Int
    var userId: Int
    var groupId: Int
    var isPersonalItem: Bool
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var groceryItemName: String
    var groceryItemPrice: Double
    var groceryItemDescription: String
    
    
    static func createNewGrocery(grocery: RMGrocery, completionHandler: (completed: Bool)->()) {
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
                    completionHandler(completed: false)
                    break
                default:
                    completionHandler(completed: false)
                    break
                }
                return
            } else {
                let json = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            }
        }
        task.resume()
    }
    
    
    static func createGroceryDictionary(groceryObject: RMGrocery) -> [String : AnyObject] {
        
        var returnDict = [String : AnyObject]()
        
        returnDict["userid"] = groceryObject.userId
        returnDict["groupid"] = groceryObject.groupId
        returnDict["personalitem"] = (groceryObject.isPersonalItem) ? "TRUE" : "FALSE"
        returnDict["groceryitemname"] = groceryObject.groceryItemName
        returnDict["groceryitemprice"] = groceryObject.groceryItemPrice
        returnDict["groceryitemdescription"] = groceryObject.groceryItemDescription

        return returnDict
    }
    
    // Public Functions
    /*
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
     */
    
    
    
    
}
