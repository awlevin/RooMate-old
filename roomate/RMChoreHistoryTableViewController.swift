//
//  RMChoreHistoryTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreHistoryTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    
    var chore: RMChore!
    var choreCompletions = [RMChoreCompletion]()
    let refresher = UIRefreshControl()
    var choreCompletionSelected: RMChoreCompletion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher.tintColor = UIColor.redColor()
        refresher.addTarget(self, action: #selector(fetchNewChoreCompletions), forControlEvents: .ValueChanged)
        tableView!.addSubview(refresher)
        
        tableView.registerNib(UINib(nibName: "RMChoreCompletionTableViewCell", bundle: nil), forCellReuseIdentifier: "CompletionCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchNewChoreCompletions()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        choreCompletionSelected = nil
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.choreCompletions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RMChoreCompletionTableViewCell = tableView.dequeueReusableCellWithIdentifier("CompletionCell", forIndexPath: indexPath) as! RMChoreCompletionTableViewCell
        
        cell.nameLabel.text = self.choreCompletions[indexPath.row].title
        cell.dateLabel.text = self.choreCompletions[indexPath.row].dateCompleted
        
        //cell.configureCell()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        (choreCompletionSelected != nil) ? print(choreCompletionSelected.title) : print(false)
        choreCompletionSelected = self.choreCompletions[indexPath.row]
        (choreCompletionSelected != nil) ? print(choreCompletionSelected.title) : print(false)

        
        print(choreCompletionSelected)
        performSegueWithIdentifier("showChoreCompletionDetail", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showChoreCompletionDetail" {
            let destinationVC = segue.destinationViewController as! RMChoreCompletionDetailTableViewController
            destinationVC.choreCompletion = choreCompletionSelected
        }
    }
    
    
    
    func fetchNewChoreCompletions() {
        let tableViewHeader = self.headerView
        
        chore.getRMChoreCompletions() { (choreCompletions) in
            var fetchedChoreCompletions = choreCompletions
            if fetchedChoreCompletions.count > 0 {
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.tableHeaderView = nil
                })
                fetchedChoreCompletions = fetchedChoreCompletions.sort( { $0.choreCompletionID > $1.choreCompletionID })
                for choreCompletion in fetchedChoreCompletions {
                    if !self.choreCompletions.contains( { $0.choreCompletionID == choreCompletion.choreCompletionID }) {
                        self.choreCompletions.append(choreCompletion)
                    }
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.tableHeaderView? = self.headerView
                })
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.choreCompletions = self.choreCompletions.sort({ $0.choreCompletionID > $1.choreCompletionID })
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            })
        }
    }
}
