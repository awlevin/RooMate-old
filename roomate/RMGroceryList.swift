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
    
    static func getGroceryList(userObjectId: Int, lastid: Int, groupId: Int, listType: RMGroceryListTypes, completionHandler: (bbPosts: [RMGrocery])->()) {
        
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
        request.addValue("1", forHTTPHeaderField: "groupid")
        request.addValue("\(lastid)", forHTTPHeaderField: "lastid")
        
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
                    completionHandler(bbPosts: [])
                    break
                default:
                    completionHandler(bbPosts: [])
                    break
                }
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    completionHandler(bbPosts: [])
                    return
                }
                
                if json.count == 0 {
                    completionHandler(bbPosts: [] )
                    return
                }
                else {
                    var returnedGroceryItems = [RMGrocery]()
                    
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String: AnyObject]
                            else { continue }
                        
                        let currItem = RMGrocery(objectId: jsonItemDict["itemid"] as! Int,
                                                 userId: jsonItemDict["userid"] as! Int,
                                                 groupId: jsonItemDict["groupid"] as! Int,
                                                 isPersonalItem: jsonItemDict["personalitem"] as! Bool,
                                                 dateCreatedAt: "" , // TODO: retrieve this field
                                                 dateUpdatedAt: "", // TODO: retrieve this field too
                                                 groceryItemName: jsonItemDict["groceryitemname"] as! String,
                                                 groceryItemPrice: jsonItemDict["groceryitemprice"] as! Double,
                                                 groceryItemDescription: jsonItemDict["groceryitemdescription"] as! String)
                        returnedGroceryItems.append(currItem)
                    }
                    completionHandler(bbPosts: returnedGroceryItems)
                    return
                }
            }
        }
        task.resume()
    }
    
    /*
    
    
    public func getPastUserGroceryList(offset: Int, count: Int) -> [RMGroceryList] {
        
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
    
    */
}
