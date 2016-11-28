//
//  SettingsViewController.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 27/11/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class SettingsViewController: UIViewController, UITableViewDelegate {
    
    var user: [String : String]!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        saveFacebookDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if user != nil{
            return 2
        }
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingscell", forIndexPath: indexPath)
        if indexPath.row == 0 {
            if user != nil{
                cell.textLabel?.text = "Welcome " + user["name"]!
            } else {
                cell.textLabel?.text = "Logout"
            }
        } else {
            cell.textLabel?.text = "Logout"
        }
        
        return cell
    }
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            FBSDKAccessToken.setCurrentAccessToken(nil)
            
            AppDelegate().window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
            
            AppDelegate().window?.rootViewController = initialViewController
            AppDelegate().window?.makeKeyAndVisible()
            
            self.presentViewController(initialViewController, animated: true, completion: {
                
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
                self.user = ["name" : "\(first_name!)"]
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                
            }
        })
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
