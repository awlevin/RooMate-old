//
//  GroupSelectionVC.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 26/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMGroupSelectionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func joinHouseholdPressed(sender: AnyObject) {
        let alert = UIAlertController(title: LoginStringConst.joinHouseholdAlertTitle, message: LoginStringConst.joinHouseholdAlertMessage, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = LoginStringConst.joinHouseholdAlertPlaceholder
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            let groupID = textField.text
            
            // Textfield is NOT empty
            if groupID != "" {
                
                let userDefaults = NSUserDefaults.standardUserDefaults()
                let userId = userDefaults.integerForKey("userID")
               
                RMGroup.joinHousehold(userId, groupID: Int(groupID!)!, completion: { (success) in
                    if success {
                        print("Successfully joined household")
                        userDefaults.setValue(groupID, forKey: "groupID")
                        self.performSegueWithIdentifier(LoginStringConst.loginSuccessSegue, sender: self)
                    } else {
                        print("Failed joining household")
                    }
                })
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func createHouseholdPressed(sender: AnyObject) {
        RMGroup.createGroup { (success, groupID) in
            if success {
                print("Successfully created household")
                
                // Save groupId
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setValue(groupID, forKey: "groupID")
                
                dispatch_async(dispatch_get_main_queue(), {
                    // Show user their groupId
                    let alert = UIAlertController(title: "Group ID: " + String(groupID!), message: "Tell your roommates to join this group id! Can be found again under settings", preferredStyle: .Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                        self.performSegueWithIdentifier(LoginStringConst.loginSuccessSegue, sender: self)
                    }))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            } else { // Error went down
                print("Failed Creating household")
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
