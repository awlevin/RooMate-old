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
    var postSelected: RMGrocery!

    
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
        postSelected = nil
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
        // TODO: Do we need to implement this method?
        // The UI doesn't permit clicking on the grocery items... but it should so that we can modify an item's quantity.
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
        RMGroceryList.getGroceryList(RMUser.returnTestUser(), listType: listType, completionHandler: { (bbPosts) in
            var fetchedItems = bbPosts
            
            
            if fetchedItems.count > 0 {
                fetchedItems = fetchedItems.sort( { $0.objectID > $1.objectID })
                switch listType {
                case RMGroceryListTypes.Personal:
                    for item in fetchedItems{
                        if !self.personalItems.contains({ $0.objectID == item.objectID }) {
                            self.personalItems.append(item)
                        }
                    }
                case RMGroceryListTypes.Communal:
                    for item in fetchedItems{
                        if !self.communalItems.contains({ $0.objectID == item.objectID }) {
                            self.communalItems.append(item)
                        }
                    }
                case RMGroceryListTypes.Aggregate:
                    for item in fetchedItems{
                        if !self.aggregateItems.contains({ $0.objectID == item.objectID }) {
                            self.aggregateItems.append(item)
                        }
                    }
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
        })
    }

}
