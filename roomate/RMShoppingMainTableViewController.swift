//
//  RMShoppingMainTableViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingMainTableViewController: UITableViewController {

    var personalItems = [RMGrocery]()
    var communalItems = [RMGrocery]()
    var aggregateItems = [RMGrocery]()
    let refresher = UIRefreshControl()
    var selectedGroceryItem: RMGrocery!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher.tintColor = UIColor.redColor()
        refresher.addTarget(self, action: #selector(fetchAllNewItems), forControlEvents: .ValueChanged)
        tableView!.addSubview(refresher)
        
        fetchAllNewItems()
        
        tableView.registerNib(UINib(nibName: "RMShoppingMainTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingMainCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let parentVC = self.parentViewController as? RMShoppingMainViewController {
            switch  parentVC.segmentedControl.selectedSegmentIndex {
            case 0:
                return communalItems.count
            case 1:
                return personalItems.count
            case 2:
                return aggregateItems.count
            default:
                return 0
            }
        } else { return 0 }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let parentVC = self.parentViewController as? RMShoppingMainViewController {
            
            switch  parentVC.segmentedControl.selectedSegmentIndex {
            
            // Communal Cells
            case 0:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.nameLabel.text = self.communalItems[indexPath.row].groceryItemName
                cell.quantityLabel.text = String(self.communalItems[indexPath.row].quantity)
                cell.configureCell()
                
                return cell
                
            // Personal Cells
            case 1:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.nameLabel.text = self.personalItems[indexPath.row].groceryItemName
                cell.quantityLabel.text = String(self.personalItems[indexPath.row].quantity)
                cell.configureCell()
                
                return cell
                
            // Aggregate Cells
            case 2:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.nameLabel.text = self.aggregateItems[indexPath.row].groceryItemName
                cell.quantityLabel.text = String(self.aggregateItems[indexPath.row].quantity)
                cell.configureCell()
                
                return cell
            
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if let parentVC = self.parentViewController as? RMShoppingMainViewController {
            switch  parentVC.segmentedControl.selectedSegmentIndex {
            case 0:
                selectedGroceryItem = communalItems[indexPath.row]
                performSegueWithIdentifier("EditGrocerySegue", sender: self)
                return
            case 1:
                selectedGroceryItem = personalItems[indexPath.row]
                performSegueWithIdentifier("EditGrocerySegue", sender: self)
                return
            case 2:
                // Don't segue on aggregate list
                return
            default:
                return
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let exGrocery: RMGrocery?
            
            if let parentVC = self.parentViewController as? RMShoppingMainViewController {
                switch  parentVC.segmentedControl.selectedSegmentIndex {
                case 0:
                    exGrocery = communalItems[indexPath.row]
                    communalItems.removeAtIndex(indexPath.row)
                case 1:
                    exGrocery = personalItems[indexPath.row]
                    personalItems.removeAtIndex(indexPath.row)
                case 2:
                    return
                default:
                    return
                }
            }
            
            // Delete row
            self.tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.endUpdates()
            
//            RMChore.deleteChore(exGrocery!.objectID) { (completed) in
//                if completed {
//                    print("Chore successfully deleted")
//                } else {
//                    // Add chore back if it wasn't successfully deleted
//                    self.chores.insert(exGrocery, atIndex: indexPath.row)
//                    self.tableView.beginUpdates()
//                    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//                    self.tableView.endUpdates()
//                    
//                    RMNotificationManger().presentSimpleAlertWithMessage("Error!", message: "We encountered a problem deleting your chore, please try again", viewController: self)
//                }
//            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func fetchNewItemsForListType(listType: RMGroceryListTypes) {
        callFetchPosts(listType)
    }
    
    func fetchAllNewItems() {
        callFetchPosts(.Personal)
        callFetchPosts(.Communal)
        callFetchPosts(.Aggregate)

    }
    
    
    func callFetchPosts(listType: RMGroceryListTypes) {
        
        let user = RMUser.getCurrentUserFromDefaults()
        
        RMGroceryList.getListByType(user, listType: .Communal) { (success, groceries) in
            if success {
                switch listType {
                case RMGroceryListTypes.Personal:
                    for item in groceries! {
                        if !self.personalItems.contains({ $0.objectID == item.objectID }) {
                            self.personalItems.append(item)
                        }
                    }
                case RMGroceryListTypes.Communal:
                    for item in groceries!{
                        if !self.communalItems.contains({ $0.objectID == item.objectID }) {
                            self.communalItems.append(item)
                        }
                    }
                case RMGroceryListTypes.Aggregate:
                    for item in groceries!{
                        if !self.aggregateItems.contains({ $0.objectID == item.objectID }) {
                            self.aggregateItems.append(item)
                        }
                    }
                }
            } else {
                print("failed to get list!")
            }
        }
        
        
        dispatch_async(dispatch_get_main_queue(), {
            switch listType {
            case RMGroceryListTypes.Personal:
                self.personalItems = self.personalItems.sort( { $0.objectID > $1.objectID } )
                break
            case RMGroceryListTypes.Communal:
                self.communalItems = self.communalItems.sort( { $0.objectID > $1.objectID } )
                break
            case RMGroceryListTypes.Aggregate:
                self.aggregateItems = self.aggregateItems.sort( { $0.objectID > $1.objectID } )
                break
            }
            
            self.tableView.reloadData()
            self.refresher.endRefreshing()
            
        })
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditGrocerySegue" {
            let nav = segue.destinationViewController as! UINavigationController
            let destinationVC = nav.topViewController as! RMShoppingAddItemTableViewController
            destinationVC.groceryItem = selectedGroceryItem
        }
    }
}
