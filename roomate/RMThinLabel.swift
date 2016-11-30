//
//  RMThinLabel.swift
//  roomate
//
//  Created by Corey Pett on 11/30/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMThinLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        self.setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup() {
        self.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
    }

}
