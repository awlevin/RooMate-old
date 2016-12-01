//
//  RMFinanceInvoiceContainerTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

protocol FinanceBottomContainerDelegate {
    func invoiceEdited()
}

class RMFinanceInvoiceBottomContainerTableViewController: UITableViewController, FinanceTableViewCellDelegate {
   
    @IBOutlet weak var totalButton: RMRoundedButton!
    
    var total: Double?
    var invoice: RMInvoice?
    var cost: Double?
    var parentVC: RMFinanceInvoiceMainViewController?
    var delegate: FinanceBottomContainerDelegate?
    
    
    static let user1 = RMUser(userObjectId: "0", groupId: "0", dateCreatedAt: "0", dateUpdatedAt: "0", firstName: "Corey", lastName: "Pett", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user2 = RMUser(userObjectId: "0", groupId: "0", dateCreatedAt: "0", dateUpdatedAt: "0", firstName: "Jim", lastName: "Skretny", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user3 = RMUser(userObjectId: "0", groupId: "0", dateCreatedAt: "0", dateUpdatedAt: "0", firstName: "Eric", lastName: "Bach", email: "0", profileImageURL: "0", userGroceryLists: nil)
    let userArray = [user1, user2, user3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "RMFinanceInvoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
        
        self.tableView.contentInset = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0)
        
        total = 0
    }
    
    func updateUI() {
        totalButton.setTitle(total?.asLocaleCurrency, forState: .Normal)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    func percentageChanged(percentage: String?, cost: Double, newTotal: Double) {
        let buttonTitle = totalButton.titleLabel!.text!
        // Remove Dollar Sign
        var totalString = String(buttonTitle.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil))
        // Remove Spaces
        totalString = String(totalString.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil))
        // Remove Comma
        totalString = String(totalString.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil))
       
        print("#############################################")
        let totalDouble = Double(totalString)
        print("Total = \(totalDouble!)")

        if percentage != "" {
            let percentage = Double(percentage!)! / 100.0
            print("Percentage = \(percentage)")
            
            total = newTotal
            print("NewTotal = \(newTotal)")
            
            totalButton.setTitle(newTotal.asLocaleCurrency, forState: .Normal)

        } else if cost != 0 {
            
            let newTotal = totalDouble! + cost
            print("NewTotal = \(newTotal)")
            
            totalButton.setTitle(newTotal.asLocaleCurrency, forState: .Normal)
        } else {
            totalButton.setTitle(total!.asLocaleCurrency, forState: .Normal)
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RMFinanceInvoiceTableViewCell = tableView.dequeueReusableCellWithIdentifier("InvoiceCell", forIndexPath: indexPath) as! RMFinanceInvoiceTableViewCell
        
        cell.parentVC = self
        cell.delegate = self
        cell.total = total
        cell.configureCell(userArray[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
