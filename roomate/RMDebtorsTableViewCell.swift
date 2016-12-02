//
//  RMDebtorsTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMDebtorsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remindButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func remindButtonPressed(sender: AnyObject) {
        
    }
    
    func configureCell(user: RMUser) {
        nameLabel.text = user.firstName + " " + user.lastName

    }
}
