//
//  RMChoreMainTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMChoreMainTableViewController: UITableViewController, ChoreMainTableViewCellDelegate {

    var chores = [RMChore]()
    let refresher = UIRefreshControl()
    var choreSelected: RMChore!
    var isAddingChore: Bool?
    
    @IBAction func addBarButtonPressed(sender: AnyObject) {
        if isAddingChore == false {
            isAddingChore = true
            
            let newChore = RMChore(choreID: 0, groupID: 0, userID: 0, title: "", description: "", dateCreated: "")
            self.chores.insert(newChore, atIndex: 0)
            
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([
                NSIndexPath(forRow: 0, inSection: 0)
                ], withRowAnimation: .Fade)
            self.tableView.endUpdates()
            
            let index = NSIndexPath(forRow: 0, inSection: 0)
            let cell = self.tableView.cellForRowAtIndexPath(index) as? RMChoreMainTableViewCell
            
            cell?.saveButton.hidden = false
            cell?.titleTextField.userInteractionEnabled = true
            cell?.lastDoneLabel.text = "Last done by - "
            cell?.selectionStyle = .None
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher.tintColor = UIColor.redColor()
        refresher.addTarget(self, action: #selector(fetchNewChores), forControlEvents: .ValueChanged)
        tableView!.addSubview(refresher)
        
        fetchNewChores()
        
        isAddingChore = false
        
        tableView.registerNib(UINib(nibName: "RMChoreMainTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoreCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        choreSelected = nil
    }
    
    // MARK: - ChoreMainTableViewCellDelegate Methods
    
    func saveNewChore(chore: RMChore) {
        // TODO: Add chore to parent tableViewController and save
        RMChore.createNewChore(chore) { (completed) in
            if completed {
                self.chores.removeAtIndex(0)
                self.chores.insert(chore, atIndex: 0)
                self.isAddingChore = false
                print("New chore successfully added")
            } else {
                RMNotificationManger().presentSimpleAlertWithMessage("Error!", message: "We encountered a problem saving your chore, please try again", viewController: self)
            }
        }
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
        
        cell.delegate = self
        
        cell.titleTextField.text = self.chores[indexPath.row].title

        cell.lastDoneLabel.text = "Last done by - " + "Corey Pett"//self.chores[indexPath.row].userID
    
        return cell
    }
    
    
    // MARK: - Cell Selecting Functions
    
    // For tapping a chore cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? RMChoreMainTableViewCell
        
        if cell?.saveButton.hidden == false {
            print("Can't select when button is not saved")
        } else {
            choreSelected = self.chores[indexPath.row]
            performSegueWithIdentifier("modalAddChoreCompletion", sender: nil)
        }
    }
    
    // For tapping the information button of a chore cell
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? RMChoreMainTableViewCell
        
        if cell?.saveButton.hidden == false {
            print("Can't select when button is not saved")
        } else {
            choreSelected = self.chores[indexPath.row]
            performSegueWithIdentifier("showChoreCompletionHistory", sender: nil)
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            isAddingChore = false
            
            let exChore = self.chores[indexPath.row]
            
            self.chores.removeAtIndex(indexPath.row)
            self.tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.endUpdates()
            
            RMChore.deleteChore(exChore.choreID) { (completed) in
                if completed {
                    print("Chore successfully deleted")
                } else {
                    self.chores.insert(exChore, atIndex: indexPath.row)
                    self.tableView.beginUpdates()
                    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.tableView.endUpdates()
                    
                    RMNotificationManger().presentSimpleAlertWithMessage("Error!", message: "We encountered a problem deleting your chore, please try again", viewController: self)
                }
            }
        }
    }
    
    
    
    // MARK: Segue functions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Segue to chore completion
        if segue.identifier == "modalAddChoreCompletion"
        {
            let nav = segue.destinationViewController as! UINavigationController
            let destinationVC = nav.topViewController as! RMChoreAddCompletionTableViewController
            destinationVC.chore = choreSelected
        }
        
        // Segue to completion history
        if segue.identifier == "showChoreCompletionHistory"
        {
            let destinationVC = segue.destinationViewController as! RMChoreHistoryTableViewController
            destinationVC.chore = choreSelected
        }
    }
    
    
    // MARK: Chore fetching functions
    func fetchNewChores() {
        let lastid = Int(INT16_MAX)
        isAddingChore = false
        removeButtonFromCells()
        callFetchChores(lastid)
    }
    
    func removeButtonFromCells() {
        for cell in tableView.visibleCells {
            let choreCell = cell as! RMChoreMainTableViewCell
            choreCell.saveButton.hidden = true
        }
    }
    
    func callFetchChores(lastid: Int?) {
        var givenLastid = 0
        if lastid != nil {
            givenLastid = lastid!
        }
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let groupID = userDefaults.valueForKey("groupID") as! Int
        
        RMChore.getChores(0, lastid: givenLastid, groupId: groupID) { (bbPosts) in
            var fetchedChores = bbPosts
            if fetchedChores.count > 0 {
                fetchedChores = fetchedChores.sort( { $0.choreID > $1.choreID })
                self.chores = fetchedChores
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.chores = self.chores.sort( { $0.choreID > $1.choreID })
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            })
        }
    }
}
