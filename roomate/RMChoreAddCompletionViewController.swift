//
//  RMChoreAddCompletionViewController.swift
//  roomate
//
//  Created by Aaron Levin on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreAddCompletionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var beforePhotoImageView: UIImageView!
    @IBOutlet weak var afterPhotoImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var isBeforePhoto = false
    
    var chore: RMChore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        updateUI()
        
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
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancelPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func completeChoreButton(sender: AnyObject) {
        
        chore.createRMChoreCompletion(RMUser.returnTestUser()) { (completed) in
            if completed {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "We encountered a problem saving your data, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(errorAlert, animated: true, completion: nil)

            }
        }
        
        //TODO: Save information to server
        if afterPhotoImageView.image != nil {
            RMChore.updateChoreAfter(self.chore.objectID, afterPhoto: getBase64ForImage(afterPhotoImageView.image!)) { (completed) in
                if completed{
                    // TODO: completion handler after saving photo
                }
            }
        }
        
        if beforePhotoImageView.image != nil {
            RMChore.updateChoreBefore(self.chore.objectID, beforePhoto: getBase64ForImage(beforePhotoImageView.image!)) { (completed) in
                if completed{
                    // TODO: completion handler after saving photo
                }
            }
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if isBeforePhoto {
                self.beforePhotoImageView.image = pickedImage
            } else {
                self.afterPhotoImageView.image = pickedImage
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getBase64ForImage(image : UIImage) -> String {
        let imageJPEG = UIImageJPEGRepresentation(image, 0.1)
        let imageData = imageJPEG?.base64EncodedStringWithOptions([.Encoding64CharacterLineLength])
        print("******************\(imageData?.characters.count)")
        return imageData!
    }
    
    func getImageForBase64(imageData: String) -> UIImage {
        let imageData = NSData(base64EncodedString: imageData, options: [.IgnoreUnknownCharacters])
        return UIImage(data: imageData!)!
    }
    
    func updateUI() {
        self.titleLabel.text = chore.title
        self.textView.text = chore.description
    }
}
