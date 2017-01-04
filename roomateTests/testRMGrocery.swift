//
//  testRMGrocery.swift
//  roomate
//
//  Created by Aaron Levin on 12/9/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest
@testable import roomate

class testRMGrocery: XCTestCase {
    
    
    func testCreateNewGrocery() {
        let asyncExpectation = expectationWithDescription("testCreateNewGrocery")
        var testSuccess = false
        let user = RMUser.returnTestUser()
        
        let grocery = RMGrocery(objectID: 0, userID: user.userObjectID, groupID: user.groupID!, isPersonalItem: true, dateCreatedAt: "", dateUpdatedAt: "", groceryItemName: "aaron's grocery!!", groceryItemPrice: 0.00, groceryItemDescription: "test description", quantity: 1, listID: 0)
        
        RMGrocery.createNewGrocery(grocery) { (completed) in
            //testSuccess = (completed) ? true : false
            if completed {
                testSuccess = completed
            }
        }
        asyncExpectation.fulfill()
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
    
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
