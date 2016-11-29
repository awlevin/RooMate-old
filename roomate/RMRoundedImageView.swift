//
//  RMRoundedImageView.swift
//  roomate
//
//  Created by Corey Pett on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMRoundedImageView: UIImageView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = self.layer.frame.height/2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}
