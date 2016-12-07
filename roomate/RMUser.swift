//
//  RMUser.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMUser : Hashable {
    
    // BEGIN: Temporary code to test everything with different RMUsers
    static func returnTestUser() -> RMUser{
        return RMUser(userObjectID: 1, groupID: 1, dateCreatedAt: "00/00/00", dateUpdatedAt: "00/00/00", firstName: "TestFirst", lastName: "UserLast", email: "testUser@trumpsucks.com", profileImageURL: "N/A", userGroceryLists: nil)
    }
    
    // END: Temporary code to test everything with RMUsers
    
    
    var userObjectID: Int
    var groupID: Int
    var dateCreatedAt: String?
    var dateUpdatedAt: String?
    var firstName: String
    var lastName: String
    var email: String
    var profileImageURL: String
   // var oneSignalId: String?
    var userGroceryLists: [RMGroceryList]?
    
    
    // TODO: Ritvik double check this. This is my attempt at making RMUser conform to Hashable.
    // We needed an appropriate hashValue, so I figured the uniqueness of userObjectID would produce a good hash value.
    public var hashValue: Int { return userObjectID.hashValue }
    
    
    // Public Functions
    
    static func createUser(user: RMUser, completion: (success: Bool, userID: Int) -> ()) {
        
        var userParamDictionary = [String : AnyObject]()
        userParamDictionary["firstname"] = user.firstName
        userParamDictionary["lastname"] = user.lastName
        userParamDictionary["email"] = user.email
        userParamDictionary["profileimageurl"] = user.profileImageURL
        
        
        RMQueryBackend.post(userParamDictionary, url: "https://damp-plateau-63440.herokuapp.com/createRMUser") { (succeeded, jsonResponse) in
            if succeeded {
                completion(success: true, userID: jsonResponse!["userid"] as! Int)
                return
            } else {
                completion(success: false, userID: 0)
                return
            }
        }
        
        
    }
    
    /*
    static func createUser(user: RMUser, completion: (success: Bool, statusCode: Int) -> Void)  {
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
                    completion(success: false, statusCode: statusCode)
                    return
                default:
                    completion(success: false, statusCode: statusCode)
                    return
                }
            } else {
//                let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err)
                
                completion(success: true, statusCode: statusCode)
            }
        }
        task.resume()
    }
     */
    
    static func doesUserExist(email: String, completion: (userExists: Bool, statusCode: Int) -> Void){
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/doesUserExist"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(email)", forHTTPHeaderField: "email")
        
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
                    completion(userExists: false, statusCode: statusCode)
                    return
                case 503:
                    completion(userExists: false, statusCode: statusCode)
                    return
                default:
                    completion(userExists: false, statusCode: statusCode)
                    return
                }
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    print("this is where we got")
                    completion(userExists: false, statusCode: statusCode)
                    return
                }
                
                if json.count == 0 {
                    print("json array was empty")
                    completion(userExists: false, statusCode: statusCode)
                    return
                }
                else {
                    var userExists = false
                    
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String : AnyObject]
                            else {
                                completion(userExists: false, statusCode: statusCode)
                                return
                        }
                        print("mycount:  \(Int(jsonItemDict["mycount"] as! String))" )

                        ( Int(jsonItemDict["mycount"] as! String) == 1) ? (userExists = true) : (userExists = false)
                    }
                    
                    completion(userExists: userExists, statusCode: statusCode)
                    return
                }
            }
        }
        task.resume()
    }
    
    
    static func getUserFromEmail(email: String, completion: (success: Bool, statusCode: Int, user: RMUser?) -> ())  {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/getRMUserByEmail"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(email)", forHTTPHeaderField: "email")
        
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
                    completion(success: false, statusCode: statusCode, user: nil)
                    return
                case 503:
                    completion(success: false, statusCode: statusCode, user: nil)
                    return
                default:
                    completion(success: false, statusCode: statusCode, user: nil)
                    return
                }
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    print("GOT HERE!!!")
                    completion(success: false, statusCode: statusCode, user: nil)
                    return
                }
                
                if json.count == 0 {
                    print("nah, got here")
                    completion(success: false, statusCode: statusCode, user: nil)
                    return
                }
                    
                    
                else {
                    
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String: AnyObject]
                            else { continue }
                        
                        
                        // TODO: EXTREMELY IMPORTANT!!! HANDLE GROUPID SENT BACK AS OPTIONAL!
                        
                        let userObjectID = jsonItemDict["userid"] as! Int
//                        let groupID = (jsonItemDict["groupid"] as? Int)!
                        
                        let groupObjID: Int
                        
                        if let tempVal = jsonItemDict["groupid"] as? Int {
                            groupObjID = tempVal
                        } else {
                            groupObjID = 0
                        }
                        
                        
                        let dateCreatedAt = "datecreatedat"
                        let dateUpdatedAt = "dateupdatedat"
                        let firstName = jsonItemDict["firstname"] as! String
                        let lastName = jsonItemDict["lastname"] as! String
                        let profileImageURL = ""/*jsonItemDict["profileimageurl"] as! String*/
                        
                        completion(success: true, statusCode: statusCode, user: RMUser(userObjectID: userObjectID, groupID: groupObjID, dateCreatedAt: dateCreatedAt, dateUpdatedAt: dateUpdatedAt, firstName: firstName, lastName: lastName, email: email, profileImageURL: profileImageURL, userGroceryLists: []))
                        
                        
                        
//                            completion(success: true, statusCode: statusCode, user: RMUser(userObjectID: (jsonItemDict["userid"] as? Int)!, groupID: (jsonItemDict["groupid"] as? Int)!, dateCreatedAt: "", dateUpdatedAt: "", firstName: jsonItemDict["firstname"] as! String, lastName: jsonItemDict["lastname"] as! String, email: "\(email)", profileImageURL: ""/*jsonItemDict["profileimageurl"] as! String*/, userGroceryLists: []))
                        return
                        
                    }
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
    
    // Two users are equal if their objectIDs are equivalent.
    return lhs.userObjectID == rhs.userObjectID
}





