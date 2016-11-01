//
//  RMShoppingCheckoutTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingCheckoutTableViewController: UITableViewController {

    @IBOutlet weak var receiptImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RMShoppingCheckoutTableViewController.cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(RMShoppingCheckoutTableViewController.donePressed))
        
        tableView.registerNib(UINib(nibName: "RMShoppingCheckoutTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckoutCell")
    }
    
    @IBAction func addReciepButtonPressed(sender: AnyObject) {
        //TODO add image picker
    }
    
    func cancelPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donePressed() {
        
        // TODO save information and send cost of bill to everybody
        
        self.navigationController?.popViewControllerAnimated(true)
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
        
        let cell:RMShoppingCheckoutTableViewCell = tableView.dequeueReusableCellWithIdentifier("CheckoutCell", forIndexPath: indexPath) as! RMShoppingCheckoutTableViewCell
        
        cell.configureCell()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
