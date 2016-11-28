//
//  DetailBBViewController.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 31/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class DetailBBViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    var bulletinPostItem: RMBulletinPost?
    let collectionCellIdentifier = "CollectionCellIdentifier"
    let tableCellIdentifier = "TableCellIdentifier"
    var defaultOrangeColor = UIColor(red: 232.0, green: 128.0, blue: 50.0, alpha: 1.0)
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if((bulletinPostItem?.comments.count)! > 2) {
          //  navigationController?.hidesBarsOnSwipe = true
        //}
        
        title = bulletinPostItem?.title
        descriptionLabel.text = bulletinPostItem?.description
        
        imageCollectionView.registerNib(UINib(nibName: "DetailBBPhotoCell", bundle: nil), forCellWithReuseIdentifier: collectionCellIdentifier)
        
        commentsTableView.registerNib(UINib(nibName: "DetailBBCommentCell", bundle: nil), forCellReuseIdentifier: tableCellIdentifier)
        
        
        commentsTableView.tableFooterView = UIView()
        tableHeight.constant = CGFloat(60*(bulletinPostItem?.comments.count)! + 40)
        //commentsTableView.layoutIfNeeded()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Image Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (bulletinPostItem?.photos.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifier, forIndexPath: indexPath) as! DetailBBPhotoCell
        if indexPath.row < bulletinPostItem?.photos.count {
            cell.cellPhoto.image = getImageForBase64((bulletinPostItem?.photos[indexPath.row])!)
        } else {
            cell.cellPhoto.image = UIImage(named: "LaunchImage")
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(collectionView.frame.width/1.25, collectionView.frame.height - 20)
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! DetailBBPhotoCell
        //cell.backgroundColor = defaultOrangeColor
        
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! DetailBBPhotoCell
        //cell.backgroundColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - Comments Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCellWithIdentifier(tableCellIdentifier, forIndexPath: indexPath) as! DetailBBCommentCell
        
        cell.commentName.text = bulletinPostItem?.comments[indexPath.row].key
        cell.commentImageView.image = UIImage(named: "LaunchImage")
        cell.commentContent.text = bulletinPostItem?.comments[indexPath.row].value
        
        cell.commentImageView.layoutIfNeeded()
        cell.commentImageView.layer.cornerRadius = cell.commentImageView.frame.size.width/2
        cell.commentImageView.clipsToBounds = true
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (bulletinPostItem?.comments.count)!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    func getBase64ForImage(image : UIImage) -> String {
        let imageJPEG = UIImageJPEGRepresentation(image, 0.5)
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
extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[startIndex.advancedBy(i)]
        }
    }
}
