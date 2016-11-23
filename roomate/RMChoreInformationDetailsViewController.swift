//
//  RMChoreAddViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreInformationDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var beforePhotoImageView: UIImageView!
    @IBOutlet weak var afterPhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Navigation Bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(RMChoreInformationDetailViewController.cancelPressed))
    }
    
    func cancelPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
