//
//  RMShoppingMainTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingMainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "RMShoppingMainTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingMainCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let parentVC = self.parentViewController as? RMShoppingMainViewController {
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
        
        if let parentVC = self.parentViewController as? RMShoppingMainViewController {
            switch  parentVC.segmentedControl.selectedSegmentIndex {
            // Debt Cells
            case 0:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.configureCell()
                
                return cell
            // Statistic Cells
            case 1:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.configureCell()
                
                return cell
            // Debtor Cells
            case 2:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.configureCell()
                
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
