//
//  RMChoreMainTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreMainTableViewController: UITableViewController {

    var chores = [RMChore]()
    let refresher = UIRefreshControl()
    var choreSelected: RMChore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher.tintColor = UIColor.redColor()
        refresher.addTarget(self, action: #selector(fetchNewChores), forControlEvents: .ValueChanged)
        tableView!.addSubview(refresher)
        
        fetchNewChores()
        
        tableView.registerNib(UINib(nibName: "RMChoreMainTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoreCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        choreSelected = nil
    }
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.chores.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RMChoreMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChoreCell", forIndexPath: indexPath) as! RMChoreMainTableViewCell
        
        cell.titleLabel.text = self.chores[indexPath.row].title
        return cell
    }
    
    
    // MARK: - Cell Selecting Functions
    
    // For tapping a chore cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Modal transition to AddChoreCompletionViewController
        choreSelected = self.chores[indexPath.row]
        performSegueWithIdentifier("modalAddChoreCompletion", sender: nil)
    }
    
    // For tapping the information button of a chore cell
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        // Show transition to ChoreCompletionHistoryViewController
        choreSelected = self.chores[indexPath.row]
        performSegueWithIdentifier("showChoreCompletionHistory", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Segue to chore completion
        if segue.identifier == "modalAddChoreCompletion"
        {
            let  destinationVC = segue.destinationViewController as! RMChoreAddCompletionViewController
            destinationVC.chore = choreSelected
        }
        
        // Segue to completion history
        if segue.identifier == "showChoreCompletionHistory"
        {
            let destinationVC = segue.destinationViewController as! RMChoreHistoryTableViewController
            destinationVC.chore = choreSelected
        }
    }
    
    func fetchNewChores() {
        let lastid = Int(INT16_MAX)
        callFetchChores(lastid)
    }
    
    func callFetchChores(lastid: Int?) {
        var givenLastid = 0
        if lastid != nil {
            givenLastid = lastid!
        }
        RMChore.getChores(0, lastid: givenLastid, groupId: 1) { (bbPosts) in
            var fetchedChores = bbPosts
            if fetchedChores.count > 0 {
                fetchedChores = fetchedChores.sort( { $0.objectID > $1.objectID })
                for chore in fetchedChores{
                    if !self.chores.contains({ $0.objectID == chore.objectID }) {
                        self.chores.append(chore)
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.chores = self.chores.sort( { $0.objectID > $1.objectID })
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            })
        }
    }
}
