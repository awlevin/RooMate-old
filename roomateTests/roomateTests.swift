//
//  roomateTests.swift
//  roomateTests
//
//  Created by Ritvik Upadhyaya on 01/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest
@testable import roomate

class roomateTests: XCTestCase {
    
    let testUser = RMUser.returnTestUser()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetPersonalGroceries() {
        var testGroceries = [RMGrocery]()
        let asyncExpectation = expectationWithDescription("testGetPersonalGroceriesFunction")
        
        RMGroceryList.getGroceryList(testUser, listType: .Personal, completionHandler: { (groceries) in
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
    }
    
    func testGetCommunalGroceries() {
        let asyncExpectation = expectationWithDescription("testGetCommunalGroceriesFunction")
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
    }
    
    func testDoesUserExist() {
        let asyncExpectation = expectationWithDescription("testDoesUserExist")
        var testGroceries = [RMGrocery]()
        
        RMGroceryList.getGroceryList(testUser, listType: ., completionHandler: <#T##(groceries: [RMGrocery]) -> ()#>)
    }
    
    
}
