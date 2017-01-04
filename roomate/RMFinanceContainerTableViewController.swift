//
//  RMFinanceContainerTableViewController.swift
//  
//
//  Created by Corey Pett on 10/31/16.
//
//

import UIKit

class RMFinanceContainerTableViewController: UITableViewController {
   
    @IBOutlet weak var totalBackgroundView: UIView!
    @IBOutlet weak var remindAllButton: RMRoundedButton!
    
    static let user1 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", firstName: "Corey", lastName: "Pett", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user2 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", firstName: "Jim", lastName: "Skretny", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user3 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", firstName: "Eric", lastName: "Bach", email: "0", profileImageURL: "0", userGroceryLists: nil)
    let userArray = [user1, user2, user3]
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var allButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "RMDebtsTableViewCell", bundle: nil), forCellReuseIdentifier: "DebtsCell")
        tableView.registerNib(UINib(nibName: "RMDebtorsTableViewCell", bundle: nil), forCellReuseIdentifier: "DebtorsCell")
        
        let defaultOrangeColor = UIColor(red: 232.0, green: 128.0, blue: 50.0, alpha: 1.0)
        
        totalBackgroundView.layer.cornerRadius = 20
        totalBackgroundView.layer.borderColor = defaultOrangeColor.CGColor
        totalBackgroundView.layer.borderWidth = 3

    }

    @IBAction func allButtonPressed(sender: AnyObject) {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let parentVC = self.parentViewController as? RMFinanceMainViewController {
            switch  parentVC.segmentedControl.selectedSegmentIndex {
            case 0:
                remindAllButton.setTitle("Pay All", forState: .Normal)
                return userArray.count
            case 1:
                return userArray.count
            case 2:
                remindAllButton.setTitle("Remind All", forState: .Normal)
                return userArray.count
            default:
                return 0
            }
        } else { return 0 }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let parentVC = self.parentViewController as? RMFinanceMainViewController {
            switch  parentVC.segmentedControl.selectedSegmentIndex {
                // Debt Cells
            case 0:
                
                let cell:RMDebtsTableViewCell = tableView.dequeueReusableCellWithIdentifier("DebtsCell", forIndexPath: indexPath) as! RMDebtsTableViewCell
                cell.configureCell(userArray[indexPath.row])
                return cell
                // Statistic Cells
            case 1:
                return UITableViewCell()
                // Debtor Cells
            case 2:
                let cell:RMDebtorsTableViewCell = tableView.dequeueReusableCellWithIdentifier("DebtorsCell", forIndexPath: indexPath) as! RMDebtorsTableViewCell
                cell.configureCell(userArray[indexPath.row])
            default:
                return UITableViewCell()
            }
        } 
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // PRESENT ALERT VIEW CONTROLLER OF DETAILS
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }

}
