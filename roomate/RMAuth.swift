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
    
    weak var viewController: UIViewController?
    
    /**
     Login a user through Firebase with any supported DSSocialTypes
     - Parameter socialType: type of social media login
     */
    
    func loginWith(loginType: RMLoginTypes, completion:  (success: Bool) -> Void) {
        switch loginType {
        case .Facebook:
            loginWithFacebook({ (success) in
                if success {
                    completion(success: true)
                } else {
                    completion(success: false)
                }
            })
        }
    }
}


// MARK: - Private functions
extension RMAuth {
    
    func loginWithFacebook(completion: (success: Bool) -> Void) {
        
        // UNCOMMENT FOR DEMO PURPOSES
        // If token already exists
        if let _ = FBSDKAccessToken.currentAccessToken() {
            completion(success: true)
        }
            // If token does not exist
        else {
            let loginManager = FBSDKLoginManager()
            let readPermission = ["public_profile", "email"]
            loginManager.logInWithReadPermissions(readPermission, fromViewController: self.viewController, handler: { (loginResult, error) in
                
                let permissionSet : Set = ["public_profile", "email"]
                
                if error != nil {
                    print("Facebook login: Error - \(error)")
                    completion(success: false)
                }
                else if loginResult!.isCancelled {
                    print("Facebook login: Is cancelled")
                    completion(success: false)
                }
                else if loginResult!.declinedPermissions.contains(permissionSet) {
                    print("Facebook login: Decline permissions")
                    completion(success: false)
                    // Handle restricted user permissions
                }
                else if loginResult!.grantedPermissions.contains(permissionSet) {
                    print("Facebook login: Granted permissions")
                    self.saveFacebookDetails()
                } else if !loginResult!.isCancelled {
                    completion(success: true)
                    return
                }
            })
        }
    }
    
    func saveFacebookDetails(){
        let requestParameters = ["fields": "id, link, email, first_name, last_name"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        graphRequest?.startWithCompletionHandler({ (connection, result, error) in
            if error != nil {
                print("Facebook login: Error - \(error)")
            }
            else {
                guard let result = result as? NSDictionary else {return}
                
                let email = result.objectForKey("email") as? String
                
                let id = result.objectForKey("id") as? String
                let first_name = result.objectForKey("first_name") as? String
                let last_name = result.objectForKey("last_name") as? String
                let profile_picture_url: String = "https://graph.facebook.com/" + id! + "/picture?type=large"

                // TODO save information to backend
                
                let user = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: nil, firstName: first_name!, lastName: last_name!, email: email!, profileImageURL: profile_picture_url, userGroceryLists: nil)
                RMUser.doesUserExist(email!, completion: { (userExists, statusCode) in
                    if userExists {
                        RMUser.createUser(user, completion: { (success, statusCode) in
                            if success {
                                print("User successfully created")
                            } else {
                                
                            }
                        })
                    } else {
                        
                    }
                })
            }
        })
    }
}
