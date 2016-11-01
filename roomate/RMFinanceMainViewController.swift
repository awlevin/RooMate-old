//
//  RMFinanceMainViewController.swift
//  
//
//  Created by Corey Pett on 10/31/16.
//
//

import UIKit

class RMFinanceMainViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func segmentDidChange(sender: AnyObject) {
        let tableVC = self.childViewControllers.first as! RMFinanceContainerTableViewController
        tableVC.tableView.reloadData()
    }
}
