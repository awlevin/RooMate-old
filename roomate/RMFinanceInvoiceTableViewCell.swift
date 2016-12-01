//
//  RMFinanceInvoiceTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

protocol FinanceTableViewCellDelegate {
    func percentageChanged(percentage: String?, cost: Double, newTotal: Double)
}

class RMFinanceInvoiceTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    var parentVC: RMFinanceInvoiceBottomContainerTableViewController?
    var delegate: FinanceTableViewCellDelegate?
    var total: Double?
    var userCost: Double?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        percentageTextField.delegate = self
        
        percentageTextField.addTarget(self, action: #selector(RMFinanceInvoiceTableViewCell.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        userCost = 0
        
    }
    func configureCell(user: RMUser) {
        
        nameLabel.text = user.firstName + " " + user.lastName
        
        if parentVC?.total != total {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if percentageTextField.text != "" {
            let percentage = Double(percentageTextField.text!)! / 100.0
            
            userCost = percentage * total!
            print("User cost = \(userCost!)")
            
            let newTotal = total! - userCost!
            print("\(nameLabel.text) Total: \(newTotal)")
            
            totalCostLabel.text = userCost!.asLocaleCurrency
            self.delegate?.percentageChanged(percentageTextField.text!, cost: userCost!, newTotal: newTotal)
        } else {
            self.delegate?.percentageChanged(percentageTextField.text!, cost: userCost!, newTotal: total!)
            print("User cost = \(userCost)")
            userCost = 0
            totalCostLabel.text = userCost?.asLocaleCurrency
        }
    }
    
    func textFieldDidChange(textField: UITextField) {
        updateUI()
    }
   
}
