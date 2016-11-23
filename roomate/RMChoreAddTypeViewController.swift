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
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donePressed() {
        
        //TODO: Add chore to parent tableViewController and save
        RMChore.createNewChore(RMChore(objectId: -1, groupId: 1, dateCompleted: "", userId: 1, description: self.descriptionTextView.text, title: self.titleTextField.text!, beforePhoto: "", afterPhoto: "", completionHistory: ["":""], commentHistory: ["":""])) { (completed) in
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }
    }
    
}
