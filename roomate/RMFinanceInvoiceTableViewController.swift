//
//  RMFinanceInvoiceMainTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 12/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

// TODO: Need array of roommates, need to be able to create a RMFinanceBill for each user
// Animation when when the user completes a bill
// Animation with red when a textfield is not filled out
class RMFinanceInvoiceTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, FinanceTableViewCellDelegate {
    
    static let user1 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", dateUpdatedAt: "0", firstName: "Corey", lastName: "Pett", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user2 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", dateUpdatedAt: "0", firstName: "Jim", lastName: "Skretny", email: "0", profileImageURL: "0", userGroceryLists: nil)
    
    static let user3 = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "0", dateUpdatedAt: "0", firstName: "Eric", lastName: "Bach", email: "0", profileImageURL: "0", userGroceryLists: nil)
    let userArray = [user1, user2, user3]


    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var totalButton: RMRoundedButton!
    
    var invoice: RMInvoice?
    var pickerOptions = ["Gas", "Electric", "Internet", "Misc"]
    
    @IBAction func completeButtonPressed(sender: AnyObject) {
        
        var isError = false
        
        // TODO: SAVE INVOICES TO USERS
        if titleTextField.text == "" {
            print("Error: Empty Textfield")
            isError = true
        }
        if totalTextField.text == "" {
            print("Error: Empty Textfield")
            isError = true
        }
        if categoryTextField.text == "" {
            print("Error: Empty Textfield")
            isError = true
        }
        
        var oneCost = false
        for (person, cost) in invoice!.debtors! {
            if cost > 0 {
                oneCost = true
            }
        }
        
        if oneCost == false {
            print("Error: One person needs to be billed")
            isError = true
        }
        
        if totalButton.titleLabel?.text != "$0.00" {
            print("Error: Check your math")
            isError = true
        }
        
        if isError == false {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "RMFinanceInvoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
        
        invoice = RMInvoice()
        invoice?.total = 0
        invoice?.debtors = [userArray[0].firstName + " " + userArray[0].lastName : 0] // Initialize
        
        titleTextField.delegate = self
        totalTextField.delegate = self
        
        titleTextField.addTarget(self, action: #selector(RMFinanceInvoiceTableViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        totalTextField.addTarget(self, action: #selector(RMFinanceInvoiceTableViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        categoryTextField.addTarget(self, action: #selector(RMFinanceInvoiceTableViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        // Setup Picker View
        let pickerView = UIPickerView()
        pickerView.delegate = self
        categoryTextField.inputView = pickerView
        
        // Setup Gesture Recognizer to remove keyboard on a tap
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(RMFinanceInvoiceTableViewController.endEditing))
        self.view.addGestureRecognizer(tap)
        
        // Setup toolbar for the top of the keyboard
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
        toolBar.barStyle = UIBarStyle.Default
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RMFinanceInvoiceTableViewController.endEditing))]
        toolBar.sizeToFit()
        categoryTextField.inputAccessoryView = toolBar
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }
    
    // MARK: - Textfield Methods
    
    func textFieldDidChange(textField: UITextField) {
        switch textField.tag {
        case titleTextField.tag:
            invoice?.title = textField.text!
            return
        case totalTextField.tag:
            if textField.text! != "" {
                invoice?.total = Double(textField.text!)
                totalButton.setTitle(invoice?.total!.asLocaleCurrency, forState: .Normal)
                
            } else {
                invoice?.total = 0.0
                totalButton.setTitle(invoice?.total!.asLocaleCurrency, forState: .Normal)
            }
            self.tableView.reloadData()
            return
        case categoryTextField.tag:
            invoice?.category = textField.text!
            return
        default:
            return
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 0 {
            guard let text = textField.text else { return true }
            
            let newLength = text.characters.count + string.characters.count - range.length
            
            return newLength <= 25 // Bool
        } else if textField.tag == 1 {
            guard let text = textField.text else { return true }
            
            let newLength = text.characters.count + string.characters.count - range.length
            
            return newLength <= 4 // Bool
        }
        
        return true
    }
    
    // MARK: - FinanceTableViewDelegate Method
    
    func percentageUpdated(newInvoice: RMInvoice) {
        self.invoice = newInvoice
        
        var newTitle = newInvoice.total
        print(newInvoice)
        // Subtract cost from title
        for (person, cost) in newInvoice.debtors! {
            print("\(person) Cost: \(cost)")
            newTitle = newTitle! - cost
            print("New button title = \(newTitle)")
        }
        
        totalButton.setTitle(newTitle!.asLocaleCurrency, forState: .Normal)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RMFinanceInvoiceTableViewCell = tableView.dequeueReusableCellWithIdentifier("InvoiceCell", forIndexPath: indexPath) as! RMFinanceInvoiceTableViewCell
        
        cell.parentVC = self
        cell.delegate = self
        cell.invoice = invoice
        cell.configureCell(userArray[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
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
