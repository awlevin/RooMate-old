//
//  RMFinanceInvoiceTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

protocol FinanceTableViewCellDelegate {
    func percentageUpdated(newInvoice: RMInvoice)
}

class RMFinanceInvoiceTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    var parentVC: RMFinanceInvoiceTableViewController?
    var delegate: FinanceTableViewCellDelegate?
    var invoice: RMInvoice?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        percentageTextField.delegate = self
        
        percentageTextField.addTarget(self, action: #selector(RMFinanceInvoiceTableViewCell.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textFieldDidChange(textField: UITextField) {
        updateUI()
    }
    
    func configureCell(user: RMUser) {
        nameLabel.text = user.firstName + " " + user.lastName
        updateUI()
    }
    
    func updateUI() {
        if percentageTextField.text != "" {
            invoice = self.parentVC?.invoice
            let percentage = Double(percentageTextField.text!)! / 100.0
            print("\(nameLabel.text!) Percentage: \(percentage)")
            
            let userCost = percentage * invoice!.total!
            print("\(nameLabel.text!) Cost: \(userCost)")
            
            let newTotal = invoice!.total! - userCost
            print("\(nameLabel.text!) Total Left: \(newTotal)")
            
            totalCostLabel.text = userCost.asLocaleCurrency

            invoice?.debtors?.updateValue(userCost, forKey: nameLabel.text!)
            print(invoice?.debtors)
            self.delegate?.percentageUpdated(invoice!)
        } else {
            totalCostLabel.text = 0.asLocaleCurrency
            invoice?.debtors?.updateValue(0, forKey: nameLabel.text!)
            self.delegate?.percentageUpdated(invoice!)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        return newLength <= 3 // Bool
    }
    
}
