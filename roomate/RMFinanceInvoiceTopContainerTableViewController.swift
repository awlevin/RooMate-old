//
//  RMFinanceInvoiceTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

protocol FinanceTopContainerDelegate {
    func titleEdited(title: String)
    func totalEdited(total: Double)
    func categoryEdited(category: String)
}

class RMFinanceInvoiceTopContainerTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var pickerOptions = ["Gas", "Electric", "Internet", "Misc"]
    var delegate: FinanceTopContainerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Picker View
        let pickerView = UIPickerView()
        pickerView.delegate = self
        categoryTextField.inputView = pickerView
        
        // Setup Gesture Recognizer to remove keyboard on a tap
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(RMFinanceInvoiceTopContainerTableViewController.endEditing))
        self.view.addGestureRecognizer(tap)
        
        // Setup toolbar for the top of the keyboard
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
        toolBar.barStyle = UIBarStyle.Default
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RMFinanceInvoiceTopContainerTableViewController.endEditing))]
        toolBar.sizeToFit()
        categoryTextField.inputAccessoryView = toolBar
        
        // Set delegates
        titleTextField.delegate = self
        totalTextField.delegate = self
        categoryTextField.delegate = self
        
        titleTextField.addTarget(self, action: #selector(RMFinanceInvoiceTopContainerTableViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        totalTextField.addTarget(self, action: #selector(RMFinanceInvoiceTopContainerTableViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        categoryTextField.addTarget(self, action: #selector(RMFinanceInvoiceTopContainerTableViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
                
    }
    
    func textFieldDidChange(textField: UITextField) {
        switch textField.tag {
        case titleTextField.tag:
            delegate?.titleEdited(textField.text!)
            return
        case totalTextField.tag:
            if textField.text! != "" {
                let total = Double(textField.text!)
                delegate?.totalEdited(total!)
            } else {
                delegate?.totalEdited(0)
            }
            return
        case categoryTextField.tag:
            delegate?.categoryEdited(textField.text!)
            return
        default:
            return
        }
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
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
