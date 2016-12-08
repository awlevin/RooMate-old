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
                    self.performSegueWithIdentifier("segueFromLogin", sender: self)
                }
            } else {
                // handle error
            }
        }
    }

}
