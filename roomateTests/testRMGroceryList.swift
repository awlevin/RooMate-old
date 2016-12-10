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
    
    func testGetPersonalGroceries() {
        let asyncExpectation = expectationWithDescription("testGetPersonalGroceriesFunction")
        let testUser = RMUser.returnTestUser()
        var testSuccess = false
        var testGroceries: [RMGrocery]? = nil
        
        RMGroceryList.getListByType(testUser, listType: .Personal, completionHandler: { (success, groceries) in
            if success {
                testSuccess = success
                testGroceries = groceries!
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertTrue(testSuccess)
            print(testGroceries)
        })
    }
    
    
    func testGetCommunalGroceries() {
        let asyncExpectation = expectationWithDescription("testGetCommunalGroceriesFunction")
        let testUser = RMUser.returnTestUser()
        var testGroceries = [RMGrocery]()
        var testSuccess = false
        
        RMGroceryList.getListByType(testUser, listType: .Communal) { (success, groceries) in
            if success {
                testSuccess = success
                testGroceries = groceries!
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertTrue(testSuccess)
            // print(testGroceries)
        })
    }
    
    func testGetAggregateGroceries() {
        let asyncExpectation = expectationWithDescription("testGetAggregateGroceriesFunction")
        let testUser = RMUser.returnTestUser()
        var testGroceries = [RMGrocery]()
        var testSuccess = false
        
        RMGroceryList.getListByType(testUser, listType: .Aggregate) { (success, groceries) in
            if success {
                testSuccess = success
                testGroceries = groceries!
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertTrue(testSuccess)
            // print(testGroceries)
        })
    }
    
    
    
    // **************************************************************************************************************
    // This function was supposed to get a user, specify their group, create a grocery, and then retrieve it.
    // But alas, this method did not work. Probably an issue with calling asynchronous functions within asynchronous functions.
    // **************************************************************************************************************
    /*
    func testGroceryLists() {
        let asyncExpectation = expectationWithDescription("testAllGroceryLists")
        var testGroceries = [RMGrocery]()
        
        
        RMUser.getUserFromEmail("malcom4@wisc.edu") { (success, statusCode, user) in
            if success && user != nil {
                print("getUser success: \(success)\n")
                
                
                RMUser.editRMUserGroupID((user?.userObjectID)!, newGroupID: 2, completion: { (success) in
                    let newGrocery = RMGrocery(objectID: 0, userID: (user?.userObjectID)!, groupID: (user?.groupID)!, isPersonalItem: true, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: "new grocery", groceryItemPrice: 20, groceryItemDescription: "this is a test description", quantity: 2, listID: 0)
                    
                    print("editUserGroupID success: \(success)\n")
                    
                    RMGrocery.createNewGrocery(newGrocery, completionHandler: { (completed) in
                        if completed {
                            print("createNewGrocery success: \(completed)")
                            
                            RMGroceryList.getListByType(user!, listType: .Personal, completionHandler: { (success, groceries) in
                                if success {
                                    print("getListType success: \(success)\n")
                                    testGroceries = groceries!
                                }
                            })
                        }
                    })
                })
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertNotNil(testGroceries)
            XCTAssertTrue(testGroceries.count > 0)
        }
    }*/
    
}
