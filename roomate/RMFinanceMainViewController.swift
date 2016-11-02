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
    
    var defaultOrangeColor = UIColor(red: 232.0/255, green: 128.0/255, blue: 50.0/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.layer.cornerRadius = 0.0
    }
    
    @IBAction func segmentDidChange(sender: AnyObject) {
        let tableVC = self.childViewControllers.first as! RMFinanceContainerTableViewController
        tableVC.tableView.reloadData()
    }
}
