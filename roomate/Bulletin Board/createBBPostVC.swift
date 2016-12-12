//
//  createBBPostVC.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 07/11/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class createBBPostVC: UIViewController, UITextViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var defaultOrangeColor = UIColor(red: 232.0, green: 128.0, blue: 50.0, alpha: 1.0)
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var imageAddedCollection : [String] = []
    
    let collectionCellIdentifier = "CollectionCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.delegate = self
        titleTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(createBBPostVC.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(createBBPostVC.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        imageCollectionView.registerNib(UINib(nibName: "DetailBBPhotoCell", bundle: nil), forCellWithReuseIdentifier: collectionCellIdentifier)
        
        descriptionTextView.text = "Enter your post description here"
        descriptionTextView.textColor = UIColor.lightGrayColor()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return (bulletinPostItem?.photos.count)!
        return imageAddedCollection.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifier, forIndexPath: indexPath) as! DetailBBPhotoCell
        if (indexPath.row >= imageAddedCollection.count){
            cell.cellPhoto.image = UIImage(named: "LaunchImage")
        }
        else {
            cell.cellPhoto.image = getImageForBase64(imageAddedCollection[indexPath.row])
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        if(indexPath.row >= imageAddedCollection.count){
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
                imagePicker.allowsEditing = true
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        imageAddedCollection.append(getBase64ForImage(image))
        imageCollectionView.reloadData()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.text = textView.text.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        if textView.text.isEmpty {
            textView.text = "Enter your post description here"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.text = textField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        if !(textField.text?.isEmpty)!{
            title = textField.text
        } else {
            title = "New Bulletin Post"
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y == 64 {
                self.view.frame.origin.y -= keyboardSize.height
            }
            else {
            
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 64 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
            
            }
        }
    }
    
    @IBAction func submitPressed(sender: AnyObject) {
        let bbtitle = self.titleTextField.text!
        let bbdescription = self.descriptionTextView.text!
        let bbObject = RMBulletinPost(objectId: -1,
                                      dateCreatedAt: "",
                                      dateupdatedAt: "",
                                      title: bbtitle, description: bbdescription, pinNote: false, photos: self.imageAddedCollection, thumbnail: "", removalDate: "", comments: ["Something":"Something"])
        
        
        
        RMBulletinPost.createNewBulletinPost(bbObject, user: RMUser.getCurrentUserFromDefaults()) { (completed) in
            if completed {
                print("COMPLETED")
            } else {
                print("NOT COMPLETED")
            }
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
