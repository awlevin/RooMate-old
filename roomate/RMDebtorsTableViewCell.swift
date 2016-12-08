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
        let bell = UIImage(named: "bell")?.imageWithRenderingMode(.AlwaysTemplate)
        remindButton.setImage(bell, forState: .Normal)
        remindButton.tintColor = UIColor.whiteColor()    }

    @IBAction func remindButtonPressed(sender: AnyObject) {
        
    }
    
    func configureCell(user: RMUser) {
        nameLabel.text = user.firstName + " " + user.lastName

    }
}
