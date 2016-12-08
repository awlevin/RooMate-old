//
//  RMChoreMainTableViewCell.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

protocol ChoreMainTableViewCellDelegate {
    func saveNewChore(chore: RMChore)
}

class RMChoreMainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lastDoneLabel: RMThinLabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var saveButton: RMRoundedButton!
    
    var delegate: ChoreMainTableViewCellDelegate?
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let user = RMUser.returnTestUser()
        
        if titleTextField.text != "" {
            let chore = RMChore(choreID: 0, groupID: user.groupID!, userID: user.userObjectID, title: titleTextField.text!, description: "", dateCreated: "00/00/00")
            saveButton.hidden = true
            titleTextField.userInteractionEnabled = false
            delegate!.saveNewChore(chore)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        saveButton.hidden = true
        titleTextField.userInteractionEnabled = false
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
