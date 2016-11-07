//
//  createBBPostVC.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 07/11/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class createBBPostVC: UIViewController, UITextViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var defaultOrangeColor = UIColor(red: 232.0, green: 128.0, blue: 50.0, alpha: 1.0)
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var imagePicker = UIImagePickerController()
    var imageAddedCollection : [UIImage] = []
    
    let collectionCellIdentifier = "CollectionCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
        
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
            cell.cellPhoto.image = imageAddedCollection[indexPath.row]
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
        imageAddedCollection.append(image)
        imageCollectionView.reloadData()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your post description here"
            textView.textColor = UIColor.lightGrayColor()
        }
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
