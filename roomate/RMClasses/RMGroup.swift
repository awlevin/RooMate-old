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

    static func doesGroupExist(groupID: Int, completion: (success: Bool, groupExists: Bool)->() ) {
        RMQueryBackend.get("https://damp-plateau-63440.herokuapp.com/doesGroupExist", parameters: ["groupid" : "\(groupID)"]) { (successful, jsonResponse) in
            let jsonItem = jsonResponse![0]
            
            let groupExistsValue = (jsonItem["mycount"] as? String == "1") ? true : false
            (successful) ? completion(success: true, groupExists: groupExistsValue) : completion(success: false, groupExists: false)
        }
    }
    
    static func createGroup(completion: (success: Bool, groupID: Int?)-> ()) {
        
        RMQueryBackend.post("https://damp-plateau-63440.herokuapp.com/createRMGroup", params: ["N/A":"N/A"]) { (successful, jsonResponse) in
            if successful{
                let groupIDValue = jsonResponse?["groupid"] as! Int
                completion(success: true, groupID: groupIDValue)
            } else {
                completion(success: false, groupID: nil)
            }
        }
    }
    
    static func getUsersInGroup(groupID: Int, completion: (success: Bool, users: [RMUser])->() ) {
        RMQueryBackend.get("https://damp-plateau-63440.herokuapp.com/get", parameters: <#T##[String : String]#>, completion: <#T##(success: Bool, jsonResponse: NSArray?) -> Void#>)
    }
}
