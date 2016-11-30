//
//  RMLoginViewController.swift
//  roomate
//
//  Created by Corey Pett on 10/24/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class RMLoginViewController: UIViewController {
    
    var auth = RMAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func facebookButtonPressed(sender: AnyObject) {
        /*auth.viewController = self
         auth.loginWithFacebook { (success) in
         if success {
         dispatch_async(dispatch_get_main_queue()) {
         self.performSegueWithIdentifier("segueFromLogin", sender: self)
         }
         } else {
         // handle error
         }
         }*/
        
        RMAuth.loginWithFacebook(self) { (token, success) in
            if success {
                RMAuth.saveFacebookDetails({ (details) in
                    if details == nil {
                        FBSDKLoginManager().logOut()
                    } else {
                        let user = RMUser(userObjectId: nil, groupId: nil, dateCreatedAt: nil, firstName: details!["first_name"]!, lastName: details!["last_name"]!, email: details!["email"]!, profileImageURL: details!["profile_picture"]!, userGroceryLists: nil)
                        RMUser.createUser(token!, user: user, completion: { (success) in
                            if success {
                                dispatch_async(dispatch_get_main_queue()) {
                                    let defaults = NSUserDefaults.standardUserDefaults()
                                    defaults.setObject(token!, forKey: "token")
                                    defaults.setObject(details!["email"]!, forKey: "email")
                                    defaults.setObject(details!["first_name"]!, forKey: "first_name")
                                    defaults.setObject(details!["profile_picture"]!, forKey: "profile_picture")
                                    defaults.setObject(details!["last_name"]!, forKey: "last_name")
                                    //self.performSegueWithIdentifier("segueFromLogin", sender: self)
                                    let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("GroupSelectionVC") as! GroupSelectionVC
                                    self.presentViewController(viewController, animated: true, completion: nil)
                                }
                            } else {
                                FBSDKLoginManager().logOut()
                            }
                        })
                    }
                })
            } else {
                FBSDKLoginManager().logOut()
            }
        }
        
        /*auth.loginWith(.Facebook) { (success) in
         if success {
         dispatch_async(dispatch_get_main_queue()) {
         self.performSegueWithIdentifier("segueFromLogin", sender: self)
         }
         } else {
         // handle error
         }
         }*/
    }
    
}
