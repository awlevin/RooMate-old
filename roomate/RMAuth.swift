//
//  RMAuth.swift
//  roomate
//
//  Created by Corey Pett on 10/24/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

enum RMLoginTypes {
    case Facebook
}

struct RMAuth {
    
    /**
     Login a user through Firebase with any supported DSSocialTypes
     - Parameter socialType: type of social media login
     */
    static func loginWithFacebook(sender: UIViewController, completion: (token: String?, success: Bool) -> Void) {
        
        // UNCOMMENT FOR DEMO PURPOSES
        // If token already exists
        if let _ = FBSDKAccessToken.currentAccessToken() {
            completion(token: nil, success: true)
        }
            // If token does not exist
        else {
            let loginManager = FBSDKLoginManager()
            let readPermission = ["public_profile", "email"]
            loginManager.logInWithReadPermissions(readPermission, fromViewController: sender, handler: { (loginResult, error) in
                
                let permissionSet : Set<String> = ["public_profile", "email"]
                
                if error != nil {
                    print("Facebook login: Error - \(error)")
                    completion(token: nil, success: false)
                }
                    
                else if loginResult!.isCancelled {
                    print("Facebook login: Is cancelled")
                    completion(token: nil,success: false)
                }
                
                else {
                    
                    var allPermsGranted = true
                    
                    
                    let grantedPerms = loginResult!.grantedPermissions as NSSet
                    let grantedPermissions = grantedPerms.allObjects.map( {"\($0)"} )
                    
                    for permission in permissionSet {
                        if !grantedPermissions.contains(permission) {
                            allPermsGranted = false
                            break
                        }
                    }
                    
                    if !allPermsGranted {
                        completion(token: nil,success: false)
                    } else {
                        let fbToken = loginResult!.token.tokenString
                        completion(token: fbToken,success: true)
                    }
                }
            })
        }
    }
    
    static func saveFacebookDetails(completion: (details: [String: String]?) -> Void){
        let requestParameters = ["fields": "id, link, email, first_name, last_name"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        graphRequest?.startWithCompletionHandler({ (connection, result, error) in
            if error != nil {
                print("Facebook login: Error - \(error)")
            }
            else {
                guard let result = result as? NSDictionary else {
                    completion(details: nil)
                    return
                }
                
                guard let email = result.objectForKey("email") as? String else {
                    completion(details: nil)
                    return
                }

                
                guard let id = result.objectForKey("id") as? String else {
                    completion(details: nil)
                    return
                }

                guard let first_name = result.objectForKey("first_name") as? String else {
                    completion(details: nil)
                    return
                }

                guard let last_name = result.objectForKey("last_name") as? String else {
                    completion(details: nil)
                    return
                }

                guard let profile_picture_url: String = "https://graph.facebook.com/" + id + "/picture?type=large" else {
                    completion(details: nil)
                    return
                }

                completion(details: ["email":email,"first_name":first_name,"last_name":last_name,"profile_picture":profile_picture_url])
                return
            }
        })
    }
    
    
    
}
