//
//  RMUser.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMUser : Hashable {
    var userObjectId: String?
    var groupId: String?
    var dateCreatedAt: String?
    var dateUpdatedAt: String?
    var firstName: String
    var lastName: String
    var email: String
    var profileImageURL: String
    var userGroceryLists: [RMGroceryList]?
    
    // TODO: Ritvik double check this. This is my attempt at making RMUser conform to Hashable.
    // We needed an appropriate hashValue, so I figured the uniqueness of userObjectId would produce a good hash value.
    public var hashValue: Int { return userObjectId!.hashValue }
    
    
    // Public Functions
    static func createUser(user: RMUser, completion: (success: Bool) -> Void)  {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/createRMUser"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        var userDictionary = [String : AnyObject]()
        userDictionary["firstname"] = user.firstName
        userDictionary["lastname"] = user.lastName
        userDictionary["email"] = user.email
        userDictionary["profileimageurl"] = user.profileImageURL
        
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(userDictionary, options: [.PrettyPrinted])
            print("**********************")
            print(NSString(data: request.HTTPBody!, encoding:NSUTF8StringEncoding)!)
        } catch let error as NSError {
            print(error)
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 8.0
        configuration.timeoutIntervalForResource = 8.0
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                switch statusCode {
                case 400:
                    completion(success: false)
                    break
                default:
                    completion(success: false)
                    break
                }
                return
            } else {
                let json = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            }
        }
        
        task.resume()
        completion(success: true)
    }
    
    static func doesUserExist(email: String, completion: (success: Bool) -> Void){
        let apiCallString = "https://damp-plateau-63440.herokuapp.com//doesUserExists"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(email)", forHTTPHeaderField: "lastid")
        
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
                    completion(success: false)
                    break
                default:
                    completion(success: false)
                    break
                }
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    completion(success: false)
                    return
                }
                
                if json.count == 0 {
                    completion(success: false)
                    return
                }
                else {
                    completion(success: true)
                    return
                }
            }
        }
        task.resume()
        
    }
}



// Conform RMUser to the Equatable protocol, so then RMUser can conform to Hashable.
// Ultimately, RMUser must conform to Hashable to be used as a key in dictionaries.
extension RMUser: Equatable {}

public func ==(lhs: RMUser, rhs: RMUser) -> Bool {
    
    // Two users are equal if their objectIds are equivalent.
    return lhs.userObjectId == rhs.userObjectId
}





