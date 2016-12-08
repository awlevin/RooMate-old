//
//  RMShoppingCheckoutTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingCheckoutListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: RMThinLabel!
    @IBOutlet weak var quantityLabel: RMThinLabel!
    
    var isCheckedOff: Bool?
    var item: RMGrocery?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.accessoryType = UITableViewCellAccessoryType.None
        isCheckedOff = false
    }
    
    func configureCell(item: RMGrocery) {
        nameLabel.text = item.groceryItemName
        quantityLabel.text = String(item.quantity)
        self.item = item
        
        if isCheckedOff == true {
            self.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            self.accessoryType = UITableViewCellAccessoryType.None
        }
    }
}
