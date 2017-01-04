//
//  BulletinBoardCellCollectionViewCell.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 31/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class BulletinBoardCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImage.image = UIImage(named: "LaunchImage")
        title.text = "Title"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        thumbnailImage.layer.cornerRadius = thumbnailImage.frame.size.width/2
        thumbnailImage.clipsToBounds = true
    }

}
