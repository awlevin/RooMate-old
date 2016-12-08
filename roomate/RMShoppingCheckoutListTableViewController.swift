//
//  RMShoppingCheckoutListTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 12/7/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingCheckoutListTableViewController: UITableViewController {

    var aggregateItems: [RMGrocery]?
    var selectedItems: [RMGrocery]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "RMShoppingCheckoutListTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingCheckoutList")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(RMShoppingCheckoutListTableViewController.cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete", style: .Done, target: self, action: #selector(RMShoppingCheckoutListTableViewController.checkoutPressed))
        self.navigationItem.title = "At Store"
    }
    
    func cancelPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func checkoutPressed() {
        
        // Grab all the groceries that were checked off
        for row in 0 ..< aggregateItems!.count {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) as! RMShoppingCheckoutListTableViewCell
            
            if cell.isCheckedOff == true {
                selectedItems?.append(cell.item!)
            }
        }
        
        self.performSegueWithIdentifier("InvoiceSegue", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = aggregateItems {
            return items.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? RMShoppingCheckoutListTableViewCell
        
        if cell!.isCheckedOff == true {
            cell!.isCheckedOff = false
            cell!.accessoryType = UITableViewCellAccessoryType.None
        } else {
            cell!.isCheckedOff = true
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RMShoppingCheckoutListTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingCheckoutList", forIndexPath: indexPath) as! RMShoppingCheckoutListTableViewCell

        cell.configureCell(aggregateItems![indexPath.row])

        return cell
    }
 

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "InvoiceSegue" {
            
        }
    }
 

}
