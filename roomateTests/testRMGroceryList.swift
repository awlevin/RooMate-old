//
//  testRMGroceryList.swift
//  roomate
//
//  Created by Aaron Levin on 12/5/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest
@testable import roomate

class testRMGroceryList: XCTestCase {
        
    func testCreateNewGrocery() {
        let asyncExpectation = expectationWithDescription("testCreateNewGrocery")
        var testSuccess = false
        let user = RMUser.returnTestUser()
        
        let grocery = RMGrocery(objectID: 0, userID: user.userObjectID, groupID: user.groupID!, isPersonalItem: true, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: "test grocery name", groceryItemPrice: 0.00, groceryItemDescription: "test description", quantity: 1, listID: 0)
        
        RMGrocery.createNewGrocery(grocery) { (completed) in
            testSuccess = (completed) ? true : false
        }
        asyncExpectation.fulfill()
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func testGetPersonalGroceries() {
        let asyncExpectation = expectationWithDescription("testGetPersonalGroceries")
        let testUser = RMUser.returnTestUser()
        
        var testSuccess = false
        var fetchedGroceries = [RMGrocery]()
        
        RMQueryBackend.get("https://damp-plateau-63440.herokuapp.com/selectRMUserGroceries", parameters: ["userid": "\(testUser.userObjectID)"]) { (success, jsonResponse) in
            
            if success {
                testSuccess = success
                
                for jsonItem in jsonResponse! {
                    guard let jsonItemDict = jsonItem as? [String: AnyObject]
                        else { continue }
                    
                    let currItem = RMGrocery(objectID: jsonItemDict["itemid"] as! Int,
                                             userID: jsonItemDict["userid"] as! Int,
                                             groupID: jsonItemDict["groupid"] as! Int,
                                             isPersonalItem: jsonItemDict["personalitem"] as! Bool,
                                             dateCreatedAt: "" , // TODO: retrieve this field
                        dateUpdatedAt: "", // TODO: retrieve this field too
                        groceryItemName: jsonItemDict["groceryitemname"] as! String,
                        groceryItemPrice: jsonItemDict["groceryitemprice"] as! Double,
                        groceryItemDescription: jsonItemDict["groceryitemdescription"] as! String, quantity: jsonItemDict["quantity"] as! Int, listID: (jsonItemDict["listid"] as? Int))
                    fetchedGroceries.append(currItem)
                }
            } else {
                testSuccess = success
            }
            asyncExpectation.fulfill()
            
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
            XCTAssertTrue(fetchedGroceries.count > 0)
        }
    }
    
    /*
    func testGetPersonalGroceries() {
        let asyncExpectation = expectationWithDescription("testGetPersonalGroceriesFunction")
        let testUser = RMUser.returnTestUser()
        var testGroceries = [RMGrocery]()
        
        RMGroceryList.getGroceryList(testUser, listType: .Personal, completionHandler: { (groceries) in
            if groceries.count > 0 {
                testGroceries = groceries
                
            } else {
                testGroceries = []
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertTrue(testGroceries.count > 0, "\(testGroceries)")
        })
    }
    
    func testGetCommunalGroceries() {
        let asyncExpectation = expectationWithDescription("testGetCommunalGroceriesFunction")
        let testUser = RMUser.returnTestUser()
        var testGroceries = [RMGrocery]()
        
        RMGroceryList.getGroceryList(testUser, listType: .Communal, completionHandler: { (groceries) in
            if groceries.count > 0 {
                testGroceries = groceries
                
            } else {
                // do nothing
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertTrue(testGroceries.count > 0, "\(testGroceries)")
        })
    }*/
    
    func testEditGrocery() {
        let asyncExpectation = expectationWithDescription("testEditGrocery")
        var testCompleted = false
        
        let grocery = RMGrocery(objectID: 1, userID: 1, groupID: 1, isPersonalItem: true, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: "Sugar (White)", groceryItemPrice: 5, groceryItemDescription: "poopie", quantity: 1, listID: 1)
        
        RMGrocery.editGrocery(grocery) { (completed) in
            testCompleted = completed
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertTrue(testCompleted)
        })
    }
    
        
    
    func testDeleteGrocery() {
        let asyncExpectation = expectationWithDescription("testEditGrocery")
        var testCompleted = false
        
        let grocery = RMGrocery(objectID: 10, userID: 1, groupID: 1, isPersonalItem: true, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: "Sugar (White)", groceryItemPrice: 5, groceryItemDescription: "new bag", quantity: 1, listID: 1)
        
        RMGrocery.deleteGrocery(grocery) { (completed) in
            testCompleted = true
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertTrue(testCompleted)
        })
    }
    
    
}
