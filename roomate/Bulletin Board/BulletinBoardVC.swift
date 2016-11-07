//
//  BulletinBoardVC.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 31/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class BulletinBoardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let identifier = "CellIdentifier"
    var defaultOrangeColor = UIColor(red: 232.0, green: 128.0, blue: 50.0, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(UINib(nibName: "BulletinBoardCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! BulletinBoardCellCollectionViewCell
        
        cell.thumbnailImage.image = UIImage(named: "LaunchImage")
        cell.title.text = "Title"
        defaultOrangeColor = cell.title.textColor
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(collectionView.frame.width/3.5, collectionView.frame.width/3.5)
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! BulletinBoardCellCollectionViewCell
        cell.backgroundColor = defaultOrangeColor
        cell.title.textColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! BulletinBoardCellCollectionViewCell
        cell.title.textColor = defaultOrangeColor
        cell.backgroundColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(LoginStringConst.detailBBPostSegue, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == LoginStringConst.detailBBPostSegue {
            let destinationVC = segue.destinationViewController as! DetailBBViewController
            
            destinationVC.bulletinPostItem = RMBulletinPost(objectId: "ABC", dateCreatedAt: "", dateupdatedAt: "", title: "Test Bulletin Post", description: "Something very long about the post will go here. This will be set once by the creator and will not be editable for the beta version", pinNote: false, photos: [], thumbnail: "", daysBeforeRemoval: 2, comments: ["Ritvik": "This is awesome", "Hunter": "It really is!"])
            
            let backItem = UIBarButtonItem()
            backItem.title = "Posts"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    @IBAction func createNewBulletinBoardObject(sender: AnyObject) {
        
    }
    
    
    
    
    //    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    //        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! BulletinBoardCellCollectionViewCell
    //        cell.title.textColor = defaultOrangeColor
    //        cell.backgroundColor = UIColor.whiteColor()
    //    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
