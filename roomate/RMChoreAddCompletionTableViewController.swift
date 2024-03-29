//
//  RMChoreAddCompletionTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 12/3/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreAddCompletionTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: RMThinLabel!
    @IBOutlet weak var beforePhotoButton: UIButton!
    @IBOutlet weak var afterPhotoButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    
    let imagePicker = UIImagePickerController()
    var isBeforePhoto = false
    var chore: RMChore!
    
    @IBAction func completeButtonPressed(sender: AnyObject) {
        
        let currentUser = RMUser.getCurrentUserFromDefaults()
        
        chore.createRMChoreCompletion(currentUser) { (completed) in
            if completed {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "We encountered a problem saving your data, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(errorAlert, animated: true, completion: nil)
                
            }
        }
        
        //TODO: Save information to server
        if beforePhotoButton.imageView?.image != nil {
            RMChore.updateChoreAfter(self.chore.choreID, afterPhoto: getBase64ForImage(beforePhotoButton.imageView!.image!)) { (completed) in
                if completed{
                    // TODO: completion handler after saving photo
                }
            }
        }
        
        if afterPhotoButton.imageView?.image != nil {
            RMChore.updateChoreBefore(self.chore.choreID, beforePhoto: getBase64ForImage(afterPhotoButton.imageView!.image!)) { (completed) in
                if completed{
                    // TODO: completion handler after saving photo
                }
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func beforePhotoButtonPressed(sender: AnyObject) {
        isBeforePhoto = true
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func afterPhotoButtonPressed(sender: AnyObject) {
        isBeforePhoto = false
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        imagePicker.delegate = self
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if isBeforePhoto {
                beforePhotoButton.imageView?.image = pickedImage
            } else {
                afterPhotoButton.imageView?.image = pickedImage
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateUI() {
        self.titleLabel.text = chore.title
        self.noteTextView.text = chore.description
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
}
