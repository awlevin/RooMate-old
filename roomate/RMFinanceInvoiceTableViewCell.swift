//
//  RMFinanceInvoiceTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMFinanceInvoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        
    }
    
}
