//
//  RMFinanceInvoiceContainerTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMFinanceInvoiceContainerTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "RMFinanceInvoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
        
    }

    @IBAction func addRoomateButtonPressed(sender: AnyObject) {
        
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
        
        let cell:RMFinanceInvoiceTableViewCell = tableView.dequeueReusableCellWithIdentifier("InvoiceCell", forIndexPath: indexPath) as! RMFinanceInvoiceTableViewCell
        
        cell.configureCell()

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
