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
}
