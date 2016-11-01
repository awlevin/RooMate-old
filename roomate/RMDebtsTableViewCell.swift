//
//  RMDebtsTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMDebtsTableViewCell: UITableViewCell {
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func payButtonPressed(sender: AnyObject) {
        
    }
    
    func configureCell() {
        
    }

}
