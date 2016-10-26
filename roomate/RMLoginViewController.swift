//
//  RMLoginViewController.swift
//  roomate
//
//  Created by Corey Pett on 10/24/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMLoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    var auth = RMAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func facebookButtonPressed(sender: AnyObject) {
        auth.viewController = self
        auth.loginWith(.Facebook) { (success) in
            if success {
                self.performSegueWithIdentifier("segue", sender: self)
            } else {
                // handle error
            }
        }
    }
}
