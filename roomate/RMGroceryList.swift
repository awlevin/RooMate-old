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
    
    static func getGroceryList(user: RMUser, listType: RMGroceryListTypes, completionHandler: (groceries: [RMGrocery])->()) {
        
        var backendURLpostfix: String
        
        switch(listType) {
        case RMGroceryListTypes.Personal:
            backendURLpostfix = "selectRMUserGroceries"
        case RMGroceryListTypes.Communal:
            backendURLpostfix = "selectRMCommunalGroceries"
        case RMGroceryListTypes.Aggregate:
            backendURLpostfix = "selectRMAggregateGroceries"
        }
        
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/\(backendURLpostfix)"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch listType {
        case .Personal:
            request.addValue("\(user.userObjectID)", forHTTPHeaderField: "userid")
            break
        case .Communal:
            request.addValue("\(user.groupID)", forHTTPHeaderField: "groupid")
            break
        case .Aggregate:
            request.addValue("\(user.groupID)", forHTTPHeaderField: "groupid")
            break
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
                    print("Encountered error 400")
                    completionHandler(groceries: [])
                    break
                case 503:
                    print("Encountered error 503")
                    completionHandler(groceries: [])
                    break
                default:
                    print("Encountered an error")
                    completionHandler(groceries: [])
                    break
                }
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    print("error serializing JSON object array")
                    completionHandler(groceries: [])
                    return
                }
                
                if json.count == 0 {
                    print("JSON object array was empty")
                    completionHandler(groceries: [] )
                    return
                }
                else {
                    var returnedGroceryItems = [RMGrocery]()
                    
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String: AnyObject]
                            else { continue }
                        
                        let currItem = RMGrocery(objectID: jsonItemDict["itemid"] as! Int,
                                                 userID: jsonItemDict["userid"] as! Int,
                                                 groupID: jsonItemDict["groupid"] as! Int,
                                                 isPersonalItem: jsonItemDict["personalitem"] as! Bool,
                                                 dateCreatedAt: "" , // TODO: retrieve this field
                                                 dateUpdatedAt: "", // TODO: retrieve this field too
                                                 groceryItemName: jsonItemDict["groceryitemname"] as! String,
                                                 groceryItemPrice: jsonItemDict["groceryitemprice"] as! Double,
                                                 groceryItemDescription: jsonItemDict["groceryitemdescription"] as! String, quantity: jsonItemDict["quantity"] as! Int, listID: (jsonItemDict["listid"] as? Int))
                        returnedGroceryItems.append(currItem)
                    }
                    completionHandler(groceries: returnedGroceryItems)
                    return
                }
            }
        }
        task.resume()
    }
}
