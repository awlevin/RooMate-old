//
//  RMShoppingMainViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingMainViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set segmentedControl UI
        segmentedControl.layer.cornerRadius = 0.0
        let attributedSegmentFont = NSDictionary(object: UIFont(name: "Montserrat-Regular", size: 14.0)!, forKey: NSFontAttributeName)
        segmentedControl.setTitleTextAttributes(attributedSegmentFont as [NSObject : AnyObject], forState: .Normal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(RMShoppingMainViewController.addGrocery))
    }

    @IBAction func segmentValueDidChange(sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(RMShoppingMainViewController.addGrocery))
        case 1:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(RMShoppingMainViewController.addGrocery))
        case 2:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "finance"), style: .Plain, target: self, action: #selector(RMShoppingMainViewController.enterCheckout))
        default:
            return
        }
        
        let tableVC = self.childViewControllers.first as! RMShoppingMainTableViewController
        tableVC.tableView.reloadData()
    }
    
    func addGrocery() {
        performSegueWithIdentifier("AddGrocerySegue", sender: self)
    }
    
    func enterCheckout() {
        performSegueWithIdentifier("EnterCheckoutSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EnterCheckoutSegue" {
            let tableVC = self.childViewControllers.first as! RMShoppingMainTableViewController
            let destinationVC = segue.destinationViewController as! RMShoppingCheckoutListTableViewController
            destinationVC.aggregateItems = tableVC.aggregateItems
        }
    }
}
