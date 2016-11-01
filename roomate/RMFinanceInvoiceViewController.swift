//
//  RMFinanceInvoiceViewController.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMFinanceInvoiceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var pickerOptions = ["Gas", "Electric", "Internet", "Misc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RMFinanceInvoiceViewController.cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(RMFinanceInvoiceViewController.donePressed))
        
        // Setup Picker View
        let pickerView = UIPickerView()
        pickerView.delegate = self
        categoryTextField.inputView = pickerView
        
        // Setup Gesture Recognizer
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(RMFinanceInvoiceViewController.endEditing))
        self.view.addGestureRecognizer(tap)

    }
    
    func endEditing() {
        self.view.endEditing(true)
    }

    func cancelPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donePressed() {
        
        // TODO: Save info to server
        
        self.navigationController?.popViewControllerAnimated(true)
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
