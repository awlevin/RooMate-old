//
//  DetailBBCommentCell.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 01/11/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class DetailBBCommentCell: UITableViewCell {

    @IBOutlet weak var commentImageView: UIImageView!
    
    @IBOutlet weak var commentContent: UILabel!
    @IBOutlet weak var commentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
