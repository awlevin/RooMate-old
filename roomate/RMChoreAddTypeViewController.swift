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
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RMChoreAddTypeViewController.cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(RMChoreAddTypeViewController.donePressed))
    }
    
    func cancelPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func donePressed() {
        
        // TODO: Add chore to parent tableViewController and save
        RMChore.createNewChore(RMChore(objectID: -1, groupID: 1, userID: 1, title: self.titleTextField.text!, description: self.descriptionTextView.text, dateCreated: "00/00/00")) { (completed) in
            if completed {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "We encountered a problem saving your data, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
            
            
        }
    }
    
}
