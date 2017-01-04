//
//  RMShoppingAddItemTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 12/7/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingAddItemTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var groceryItem: RMGrocery?
    var pickerOptions = ["Dairy", "Meat & Fish", "Bread", "Snacks", "Canned Food", "Drinks", "Misc"]
    
    @IBAction func editButtonPressed(sender: AnyObject) {
        let isPersonalItem: Bool
        if self.segmentControl.selectedSegmentIndex == 0 { isPersonalItem = true }
        else { isPersonalItem = false }
        
        // Create new grocery object
        let testUser = RMUser.getCurrentUserFromDefaults()
        
        let newItem = RMGrocery(objectID: groceryItem!.objectID, userID: testUser.userObjectID, groupID: testUser.groupID!, isPersonalItem: isPersonalItem, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: self.itemTextField.text!, groceryItemPrice: 0.00, groceryItemDescription: self.textView.text, quantity: Int(self.quantityLabel.text!)!, listID: -1)
        
            // Save the grocery object to the backend
            RMGrocery.editGrocery(newItem) { (completed) in
                print("completed: \(completed)")
                if(completed) {
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                }
                else {
                    let errorAlert = UIAlertController(title: "Error", message: "We encountered a problem saving your data, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                }

            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBAction func stepperDidChange(sender: UIStepper) {
        self.quantityLabel.text = Int(sender.value).description
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func completeButtonPressed(sender: AnyObject) {
        // Determine if item is personal or not
        let isPersonalItem: Bool
        if self.segmentControl.selectedSegmentIndex == 0 { isPersonalItem = true }
        else { isPersonalItem = false }
        
        // Create new grocery object
        let currUser = RMUser.getCurrentUserFromDefaults()
        let newItem = RMGrocery(objectID: -1, userID: currUser.userObjectID, groupID: currUser.groupID!, isPersonalItem: isPersonalItem, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: self.itemTextField.text!, groceryItemPrice: 0.00, groceryItemDescription: self.textView.text, quantity: Int(self.quantityLabel.text!)!, listID: -1)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup textfield delegates
        self.itemTextField.delegate = self
        self.brandTextField.delegate = self
        self.categoryTextField.delegate = self
        
        // Setup toolbar for the top of the keyboard
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
        toolBar.barStyle = UIBarStyle.Default
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RMFinanceInvoiceTableViewController.endEditing))]
        toolBar.sizeToFit()
        categoryTextField.inputAccessoryView = toolBar

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Set grocery item information if editing a grocery item
        if let item = groceryItem {
            itemTextField.text = item.groceryItemName
            // brandTextField.text = item.brandName
            // categoryTextField.text = item.categoryName
            textView.text = item.groceryItemDescription
            quantityLabel.text = String(item.quantity)
        }
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    // MARK: - UITextField Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        itemTextField.resignFirstResponder()
        brandTextField.resignFirstResponder()
        categoryTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerView Methods
    
    func doneWithPickerPressed(sender: UIBarButtonItem) {
        categoryTextField.resignFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = pickerOptions[row]
    }
}
