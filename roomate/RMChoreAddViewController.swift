//
//  RMChoreAddViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var beforePhotoImageView: UIImageView!
    @IBOutlet weak var afterPhotoImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var isBeforePhoto = false
    
    var chore: RMChore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Navigation Bar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RMFinanceInvoiceViewController.cancelPressed))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(RMChoreAddViewController.donePressed))
    
        imagePicker.delegate = self
        
        if chore == nil {
            let alertController = UIAlertController(title: "Error", message:
                "Sorry, something went wrong. Please refresh the list of chores!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Return", style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in self.cancelPressed()}))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            self.titleLabel.text = chore.title
            self.textView.text = chore.description
        }

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
    
    func cancelPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donePressed() {
        
        //TODO: Save information to server
        if afterPhotoImageView.image != nil {
            RMChore.updateChoreAfter(self.chore.objectId, afterPhoto: getBase64ForImage(afterPhotoImageView.image!)) { (completed) in
                if completed{
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
        
        if beforePhotoImageView.image != nil {
            RMChore.updateChoreBefore(self.chore.objectId, beforePhoto: getBase64ForImage(beforePhotoImageView.image!)) { (completed) in
                if completed{
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
    
}
