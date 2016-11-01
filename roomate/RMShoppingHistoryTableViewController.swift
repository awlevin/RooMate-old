//
//  RMShoppingHistoryTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingHistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "RMShoppingHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RMShoppingHistoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath) as! RMShoppingHistoryTableViewCell
        
        cell.configureCell()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CompleteCheckoutSegue" {
            
        }
    }

}
