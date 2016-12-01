//
//  RMFinanceInvoiceMainViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMFinanceInvoiceMainViewController: UIViewController, FinanceTopContainerDelegate, FinanceBottomContainerDelegate {
    
    var invoice: RMInvoice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invoice = RMInvoice()
    }
    
    @IBAction func completeButtonPressed() {
        
        // TODO** SAVE BILLS

        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    // MARK: -  FinanceTopContainerDelegate Methods
    
    func titleEdited(title: String) {
        invoice?.title = title
    }
    
    func totalEdited(total: Double) {
        let bottomVC = self.childViewControllers[0] as? RMFinanceInvoiceBottomContainerTableViewController
        
        invoice?.total = total
        
        // Pass data down to bottom VC
        bottomVC!.total = total
        bottomVC?.updateUI()
    }
    
    func categoryEdited(category: String) {
        invoice?.category = category
    }
    
    // MARK: - FinanceBottomContainerDelegate Methods
    
    func invoiceEdited() {
        
    }
    
    // MARK: - Embeded Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "topContainer" {
            let destinationVC = segue.destinationViewController as? RMFinanceInvoiceTopContainerTableViewController
            destinationVC!.delegate = self
        }
        
        if segue.identifier == "bottomContainer" {
            let destinationVC = segue.destinationViewController as? RMFinanceInvoiceBottomContainerTableViewController
            destinationVC?.delegate = self
            destinationVC?.invoice = invoice
        }
    }
}
