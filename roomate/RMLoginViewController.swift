//
//  RMLoginViewController.swift
//  roomate
//
//  Created by Corey Pett on 10/24/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMLoginViewController: UIViewController {

    var auth = RMAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func facebookButtonPressed(sender: AnyObject) {
        auth.viewController = self
        auth.loginWithFacebook { (success) in
            if success {
                dispatch_async(dispatch_get_main_queue()) {
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    let groupID = userDefaults.integerForKey("groupID")
                    if groupID != 0 {
                        RMGroup.getUsersInGroup(Int(groupID), completion: { (success, users) in
                            if success {
                                print(users)
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.performSegueWithIdentifier("loginSuccessSegue", sender: self)

                                })
                            }
                        })
                    } else {
                        self.performSegueWithIdentifier("segueToConfigGroup", sender: self)
                    }
                }
            } else {
                // handle error
            }
        }
    }

}
