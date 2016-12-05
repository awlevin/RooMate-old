//
//  RMChoreCompletionDetailTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 12/3/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreCompletionDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: RMThinLabel!
    @IBOutlet weak var nameLabel: RMThinLabel!
    @IBOutlet weak var dateLabel: RMThinLabel!
    @IBOutlet weak var beforePhotoButton: RMRoundedButton!
    @IBOutlet weak var afterPhotoButton: RMRoundedButton!
    @IBOutlet weak var notesTextView: UITextView!
    
    var choreCompletion: RMChoreCompletion!

    @IBAction func beforePhotoButtonPressed(sender: AnyObject) {
        // TODO SHOW FULL IMAGE OF THE PHOTO
    }

    @IBAction func afterPhotoButtonPressed(sender: AnyObject) {
        // TODO SHOW FULL IMAGE OF THE PHOTO
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        titleLabel.text = choreCompletion.title
        dateLabel.text = "Date: \(choreCompletion.dateCompleted)"
        notesTextView.text = choreCompletion.additionalComments
        nameLabel.text = "\(choreCompletion.personCompletedUserID)" // TODO: Change this to the name of the person
    
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
}
