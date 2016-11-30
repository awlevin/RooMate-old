//
//  RMFinanceInvoiceTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

protocol FinanceTableViewCellDelegate {
    func percentageChanged(percentage: String?)
}

class RMFinanceInvoiceTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var totalCostLabel: RMThinLabel!
    
    var parentVC: RMFinanceInvoiceContainerTableViewController?
    var delegate: FinanceTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        percentageTextField.delegate = self
        
        percentageTextField.addTarget(self, action: #selector(RMFinanceInvoiceTableViewCell.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(user: RMUser) {
        
        nameLabel.text = user.firstName + " " + user.lastName
        
    }
    
    func textFieldDidChange(textField: UITextField) {
        self.delegate?.percentageChanged(textField.text!)
    }
   
}
