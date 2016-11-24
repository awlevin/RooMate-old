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
        
        tableView.registerNib(UINib(nibName: "RMShoppingMainTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingMainCell")
        
        refresher.tintColor = UIColor.redColor()
        //refresher.addTarget(self, action: #selector(fetchNewItemsForListType), forControlEvents: .ValueChanged)
        tableView!.addSubview(refresher)
        
        fetchNewItemsForListType(RMGroceryListTypes.Personal)
        fetchNewItemsForListType(RMGroceryListTypes.Communal)
        fetchNewItemsForListType(RMGroceryListTypes.Aggregate)

    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let parentVC = self.parentViewController as? RMShoppingMainViewController {
            switch  parentVC.segmentedControl.selectedSegmentIndex {
            case 0:
                return 0
            case 1:
                return 0
            case 2:
                return 0
            default:
                return 0
            }
        } else { return 0 }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let parentVC = self.parentViewController as? RMShoppingMainViewController {
            switch  parentVC.segmentedControl.selectedSegmentIndex {
            // Debt Cells
            case 0:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.configureCell()
                
                return cell
            // Statistic Cells
            case 1:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.configureCell()
                
                return cell
            // Debtor Cells
            case 2:
                let cell:RMShoppingMainTableViewCell = tableView.dequeueReusableCellWithIdentifier("ShoppingMainCell", forIndexPath: indexPath) as! RMShoppingMainTableViewCell
                
                cell.configureCell()
                
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func fetchNewItemsForListType(listType: RMGroceryListTypes) {
        let lastid = Int(INT16_MAX) // TODO: make this accurate
        callFetchPosts(lastid, listType: listType)
    }
    
    func callFetchPosts(lastid: Int?, listType: RMGroceryListTypes) {
        var givenLastid = 0
        if lastid != nil {
            givenLastid = lastid!
        }
        
        var items: [RMGrocery]
        
        switch(listType) {
        case RMGroceryListTypes.Personal:
            items = self.personalItems
            break
        case RMGroceryListTypes.Communal:
            items = self.communalItems
            break
        case RMGroceryListTypes.Aggregate:
            items = self.aggregateItems
            break
        }
        
        RMGroceryList.getGroceryList(0, lastid: 0, groupId: 1, listType: listType, completionHandler: { (bbPosts) in
            var fetchedItems = bbPosts
            if fetchedItems.count > 0 {
                fetchedItems = fetchedItems.sort( { $0.objectId > $1.objectId })
                for item in fetchedItems{
                    if !items.contains({ $0.objectId == item.objectId }) {
                        items.append(item)
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                items = items.sort( { $0.objectId > $1.objectId })
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            })
        })
    }

}
