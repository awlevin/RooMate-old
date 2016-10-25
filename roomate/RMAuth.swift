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
import Firebase
import FirebaseAuth

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
private extension RMAuth {
    
    func loginWithFacebook(completion: (success: Bool) -> Void) {
        // If token already exists
        if let _ = FBSDKAccessToken.currentAccessToken() {
            loginWithFirebase(.Facebook, completion: { (user) in
                print("Facebook login: Success")
                self.saveFacebookDetails(user!)
                completion(success: true)
            })
        }
            // If token does not exist
        else {
            let loginManager = FBSDKLoginManager()
            let readPermission = ["public_profile", "email", "user_posts"]
            loginManager.logInWithReadPermissions(readPermission, fromViewController: self.viewController, handler: { (loginResult, error) in
                
                let permissionSet : Set = ["public_profile", "email", "user_posts"]
                
                if error != nil {
                    print("Facebook login: Error - \(error)")
                }
                else if loginResult!.isCancelled {
                    print("Facebook login: Is cancelled")
                }
                else if loginResult!.declinedPermissions.contains(permissionSet) {
                    print("Facebook login: Decline permissions")
                    // Handle restricted user permissions
                }
                else if loginResult!.grantedPermissions.contains(permissionSet) {
                    print("Facebook login: Granted permissions")
                    
                    self.loginWithFirebase(.Facebook, completion: { (user) in
                        self.saveFacebookDetails(user!)
                        completion(success: true)
                    })
                }
            })
        }
    }
    
    private func saveFacebookDetails(user: FIRUser){
        let requestParameters = ["fields": "id, link, email, first_name, last_name, feed"]
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
                
                //TODO: Create dictionary of user data to save to firebase
                //let userProfileInfo: [String : Any] = [DSUserKey.firstName : first_name,

                // TODO create firebase backend
                //  let databaseReference = FIRDatabase.database().reference()
                //  let backend = DSBackendBridge(databaseReference: databaseReference, forDataType: .user)
                //  backend.append(newRecord: userProfileInfo, atRefPoint: .users, withId: user.uid)
                
            }
        })
    }
    
    private func loginWithFirebase(socialType: RMLoginTypes, completion: (user: FIRUser?) -> Void) {
        let credential: FIRAuthCredential?
        
        switch socialType {
        case .Facebook:
            credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            
            FIRAuth.auth()?.signInWithCredential(credential!, completion: { (user, error) in
                if error != nil {
                    print("Firebase login: Error - \(error)")
                    completion(user: nil)
                }
                else {
                    print("Firebase login: Success")
                    completion(user: user)
                }
            })
        }
    }

}
