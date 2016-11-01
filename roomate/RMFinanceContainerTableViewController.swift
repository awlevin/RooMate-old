//
//  RMFinanceContainerTableViewController.swift
//  
//
//  Created by Corey Pett on 10/31/16.
//
//

import UIKit

class RMFinanceContainerTableViewController: UITableViewController {
   
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var allButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "RMDebtsTableViewCell", bundle: nil), forCellReuseIdentifier: "DebtsCell")
        tableView.registerNib(UINib(nibName: "RMDebtorsTableViewCell", bundle: nil), forCellReuseIdentifier: "DebtorsCell")

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
                return 0
            case 1:
                return 0
            case 2:
                return 0
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
                cell.configureCell()
                return cell
                // Statistic Cells
            case 1:
                return UITableViewCell()
                // Debtor Cells
            case 2:
                let cell:RMDebtorsTableViewCell = tableView.dequeueReusableCellWithIdentifier("DebtorsCell", forIndexPath: indexPath) as! RMDebtorsTableViewCell
                cell.configureCell()
            default:
                return UITableViewCell()
            }
        } 
        return UITableViewCell()
    }

}
