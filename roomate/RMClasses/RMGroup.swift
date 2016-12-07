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
    
    public static func joinHousehold(groupId: Int){
        //Call the backend to add the current user to the household, and on
        //success, actually log them in.
    }
    
    public static func doesGroupExist(groupID: Int, completion: (groupExists: Bool, statusCode: Int)->() ) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/doesGroupExist"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(groupID)", forHTTPHeaderField: "groupid")
        
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
                    completion(groupExists: false, statusCode: statusCode)
                    return
                case 503:
                    completion(groupExists: false, statusCode: statusCode)
                    return
                default:
                    completion(groupExists: false, statusCode: statusCode)
                    return
                }
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    print("this is where we got")
                    completion(groupExists: false, statusCode: statusCode)
                    return
                }
                
                if json.count == 0 {
                    print("json array was empty")
                    completion(groupExists: false, statusCode: statusCode)
                    return
                }
                else {
                    var userExists = false
                    
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String : AnyObject]
                            else {
                                completion(groupExists: false, statusCode: statusCode)
                                return
                        }
                        print("mycount:  \(Int(jsonItemDict["mycount"] as! String))" )
                        
                        ( Int(jsonItemDict["mycount"] as! String) == 1) ? (userExists = true) : (userExists = false)
                    }
                    
                    completion(groupExists: userExists, statusCode: statusCode)
                    return
                }
            }
        }
        task.resume()
    }
}
