//
//  RMDebtsTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMDebtsTableViewCell: UITableViewCell {
  
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let dollarSign = UIImage(named: "finance")?.imageWithRenderingMode(.AlwaysTemplate)
        payButton.setImage(dollarSign, forState: .Normal)
        payButton.tintColor = UIColor.whiteColor()
        
        let close = UIImage(named: "close")?.imageWithRenderingMode(.AlwaysTemplate)
        cancelButton.setImage(close, forState: .Normal)
        cancelButton.tintColor = UIColor.whiteColor()
    }

    @IBAction func payButtonPressed(sender: AnyObject) {
        
    }
    
    func configureCell(user: RMUser) {
        nameLabel.text = user.firstName + " " + user.lastName
    }

}
