//
//  RMShoppingAddViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingAddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector (RMShoppingAddViewController.donePressed))
        
        // Setup textfield delegates
        self.itemTextField.delegate = self
        self.brandTextField.delegate = self
        self.categoryTextField.delegate = self
    }
    
    @IBAction func stepperDidChange(sender: UIStepper) {
        self.quantityLabel.text = Int(sender.value).description
    }
    
    @IBAction func cancelPressed() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func donePressed() {
        
        // Determine if item is personal or not
        let isPersonalItem: Bool
        if self.segmentControl.selectedSegmentIndex == 0 { isPersonalItem = true }
        else { isPersonalItem = false }
        
        // Create new grocery object
        let testUser = RMUser.returnTestUser()
        let newItem = RMGrocery(objectID: -1, userID: testUser.userObjectID, groupID: testUser.groupID, isPersonalItem: isPersonalItem, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: self.itemTextField.text!, groceryItemPrice: 0.00, groceryItemDescription: self.textView.text, quantity: Int(self.quantityLabel.text!)!, listID: -1)
        
        // Save the grocery object to the backend
        RMGrocery.createNewGrocery(newItem) { (completed) in
            print("completed: \(completed)")
            if(completed) {
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                let errorAlert = UIAlertController(title: "Error", message: "We encountered a problem saving your data, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        itemTextField.resignFirstResponder()
        brandTextField.resignFirstResponder()
        categoryTextField.resignFirstResponder()
        return true
    }
}
