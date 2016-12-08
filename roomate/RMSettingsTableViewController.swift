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
    
    static let user1 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", firstName: "Corey", lastName: "Pett", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user2 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", firstName: "Jim", lastName: "Skretny", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user3 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", firstName: "Eric", lastName: "Bach", email: "0", profileImageURL: "0", userGroceryLists: nil)
    let userArray = [user1, user2, user3]

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var groupIdLabel: RMThinLabel!
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setRounded()

        // Display user information
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let groupID = userDefaults.valueForKey("groupID") as? Int
        
        groupIdLabel.text = "Group ID: \(groupID!)"
        
        if let profileImageString = userDefaults.valueForKey("profilePictureURL") as? String {
            profileImageView.imageFromUrl(profileImageString)
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
