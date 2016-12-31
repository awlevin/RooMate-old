//
//  RMSettingsTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 12/8/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class RMSettingsTableViewController: UITableViewController {
    
    var userArray = [RMUser]()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var groupIdLabel: RMThinLabel!
    
    @IBAction func leaveGroupButton(sender: AnyObject) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let userId = userDefaults.integerForKey("userID")
        
        RMUser.editRMUserGroupID(userId, newGroupID: nil) { (success) in
            if success {
                userDefaults.setValue(nil, forKey: "groupID")
                
                dispatch_async(dispatch_get_main_queue(), {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginViewController = storyboard.instantiateViewControllerWithIdentifier("GroupSelectionVC")
                    UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
                })
            } else {
                RMNotificationManger().presentSimpleAlertWithMessage("Error!", message: "Please try again", viewController: self)
            }
        }
    }
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setRounded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Display user information
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let groupID = userDefaults.integerForKey("groupID")
        
        groupIdLabel.text = "Group ID: \(groupID)"
        
        if let profileImageString = userDefaults.valueForKey("profilePictureURL") as? String {
            profileImageView.imageFromUrl(profileImageString)
        }
        
        RMGroup.getUsersInGroup(groupID) { (success, users) in
            print("Get other users success: \(success)")
            if success {
                print("\(users!)")
                dispatch_async(dispatch_get_main_queue()) {
                    for user in users! {
                        if !self.userArray.contains(user) {
                            self.userArray.append(user)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return userArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell")
        
        cell?.textLabel?.text = userArray[indexPath.row].firstName + " " + userArray[indexPath.row].lastName
        
        return cell!
    }
}
