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
            saveFacebookDetails()
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
                else {
                    print("Facebook login: Granted permissions")
                    self.saveFacebookDetails()
                    completion(success: true)
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
                
                
                let user = RMUser(userObjectID: 0, groupID: nil, dateCreatedAt: nil, firstName: first_name!, lastName: last_name!, email: email!, profileImageURL: profile_picture_url, userGroceryLists: nil)
                
                
                // Update or save user information to backend
                RMUser.doesUserExist(email!, completion: { (userExists, statusCode) in
                    if !userExists {
                        // If user does not exist, create a new one
                        RMUser.createUser(user) { (success, userID) in
                            if success {
                                let userDefaults = NSUserDefaults.standardUserDefaults()
                                userDefaults.setValue(userID, forKey: "userID")
                                userDefaults.setValue(email, forKey: "email")
                                userDefaults.setValue(first_name, forKey: "firstName")
                                userDefaults.setValue(last_name, forKey: "lastName")
                                userDefaults.setValue(profile_picture_url, forKey: "profilePictureURL")
                        
                                print("User successfully created")
                            } else {
                                print("Creating a new user failed")
                            }
                        }
                        
                    } else {                        
                        // Update info from backend
                        RMUser.getUserFromEmail(email!, completion: { (success, statusCode, user) in
                            if success {
                                let userDefaults = NSUserDefaults.standardUserDefaults()
                                userDefaults.setValue(user!.userObjectID, forKey: "userID")
                                userDefaults.setObject(user!.groupID, forKey: "groupID")
                                userDefaults.setValue(email, forKey: "email")
                                userDefaults.setValue(first_name, forKey: "firstName")
                                userDefaults.setValue(last_name, forKey: "lastName")
                                userDefaults.setValue(profile_picture_url, forKey: "profilePictureURL")
                            }
                        })
                    }
                })
            }
        })
    }
}
