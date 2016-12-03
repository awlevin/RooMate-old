//
//  RMChoreCompletionDetailViewController.swift
//  roomate
//
//  Created by Aaron Levin on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreCompletionDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completionDateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var completedByLabel: UILabel!
    @IBOutlet weak var beforePhotoImageView: UIImageView!
    @IBOutlet weak var afterPhotoImageView: UIImageView!
    
    var choreCompletion: RMChoreCompletion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = choreCompletion.title
        completionDateLabel.text = "Date: \(choreCompletion.dateCompleted)"
        textView.text = choreCompletion.additionalComments
        completedByLabel.text = "\(choreCompletion.personCompletedUserID)" // TODO: Change this to the name of the person
    }
    
    func cancelPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
