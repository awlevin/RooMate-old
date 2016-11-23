//
//  RMChoreMainTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreMainTableViewController: UITableViewController {

    var posts = [RMChore]()
    let refresher = UIRefreshControl()
    var postSelected: RMChore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher.tintColor = UIColor.redColor()
        refresher.addTarget(self, action: #selector(fetchNewPosts), forControlEvents: .ValueChanged)
        tableView!.addSubview(refresher)
        
        fetchNewPosts()
        
        tableView.registerNib(UINib(nibName: "RMChoreMainTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoreCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        postSelected = nil
    }
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RMChoreMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChoreCell", forIndexPath: indexPath) as! RMChoreMainTableViewCell
        
        cell.titleLabel.text = self.posts[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //showChoreDetail
        postSelected = self.posts[indexPath.row]
        performSegueWithIdentifier("showChoreDetail", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showChoreDetail" {
            let destinationVC = segue.destinationViewController as! RMChoreAddViewController
            destinationVC.chore = postSelected
        }
    }

    
    func fetchNewPosts() {
        let lastid = Int(INT16_MAX)
        callFetchPosts(lastid)
    }
    
    func callFetchPosts(lastid: Int?) {
        var givenLastid = 0
        if lastid != nil {
            givenLastid = lastid!
        }
        RMChore.getNewChores(0, lastid: givenLastid, groupId: 1) { (bbPosts) in
            var fetchedPosts = bbPosts
            if fetchedPosts.count > 0 {
                fetchedPosts = fetchedPosts.sort( { $0.objectId > $1.objectId })
                for post in fetchedPosts{
                    if !self.posts.contains({ $0.objectId == post.objectId }) {
                        self.posts.append(post)
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.posts = self.posts.sort( { $0.objectId > $1.objectId })
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            })
        }
    }

}
