//
//  RMGroup.swift
//  roomate
//
//  Created by Aaron Levin on 26/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMGroup {
    var groupID: String
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
    
    static func getUsersInGroup(groupID: Int, completion: (success: Bool, users: [RMUser]?)->() ) {
        RMQueryBackend.get("https://damp-plateau-63440.herokuapp.com/getUsersInGroup", parameters: ["groupid":"\(groupID)"]) { (successful, jsonResponse) in
            if successful {
                
                var usersInGroup = [RMUser]()
                for jsonItem: [String : AnyObject] in jsonResponse! as! [Dictionary<String, AnyObject>] {
                    print(usersInGroup)
                    let groupMember = RMUser.parseUserJSONObject(jsonItem)
                    
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    let fullName = groupMember.firstName + " " + groupMember.lastName
                    
                    userDefaults.setValue(fullName, forKey: String(groupMember.userObjectID))
                    
                    usersInGroup.append(groupMember)
                }
                completion(success: true, users: usersInGroup)
            } else {
                completion(success: false, users: nil)
            }
        }
    }
    
    static func joinHousehold(userID: Int, groupID: Int, completion: (success: Bool) -> ()) {
        
        RMGroup.doesGroupExist(groupID) { (successful, groupExists) in
            
            // TODO: Return in completion handler whether or not the group exists?
            // So the user can be prompted whether or not the group exists
            if successful && groupExists {
                RMUser.editRMUserGroupID(userID, newGroupID: groupID) { (success) in
                    (success) ? completion(success: true) : completion(success: false)
                }
            } else {
                completion(success: false)
            }
            
        }
    }
}
