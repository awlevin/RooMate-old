//
//  RMChoreAddTypeViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreAddTypeViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RMChoreAddTypeViewController.cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(RMChoreAddTypeViewController.donePressed))
    }
    
    func cancelPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donePressed() {
        
        //TODO: Add chore to parent tableViewController and save
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
