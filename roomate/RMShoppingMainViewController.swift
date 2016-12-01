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
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func segmentValueDidChange(sender: AnyObject) {
        let tableVC = self.childViewControllers.first as! RMShoppingMainTableViewController
        tableVC.tableView.reloadData()
        
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            return
//        case 1:
//            return
//        case 2:
//            
//            // TODO: CHANGE RIGHT BAR BUTTON TO "START SHOPPING"
//            
//            return
//        default:
//            return
//        }
    }
    
    @IBAction func rightBarButtonPressed(sender: AnyObject) {
        if rightBarButton.title == "Start Shopping" {
            performSegueWithIdentifier("CompleteCheckoutSegue", sender: self)
        } else {
            performSegueWithIdentifier("AddGrocerySegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddGrocerySegue" {
            
        } else if segue.identifier == "CompleteCheckoutSegue" {
            
        } else if segue.identifier == "EditGrocerySegue" {
            // TODO: Pass grocery to destination view controller to display
        }
        
    }
}
