//
//  testRMUser.swift
//  roomate
//
//  Created by Aaron Levin on 12/5/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest
@testable import roomate

class testRMUser: XCTestCase {
    
    var firstExistingUser = RMUser(userObjectID: 2, groupID: 2, dateCreatedAt: "00/00/00", dateUpdatedAt: "00/00/00", firstName: "Bucky", lastName: "Badger", email: "bbadger@wisc.edu", profileImageURL: "N/A", userGroceryLists: nil)
    
    var secondExistingUser = RMUser(userObjectID: 3, groupID: 2, dateCreatedAt: "00/00/00", dateUpdatedAt: "00/00/00", firstName: "Maxwell", lastName: "Splinter", email: "maxsplints@fakename.com", profileImageURL: "N/A", userGroceryLists: nil)
    
    let nonExistingUser = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "00/00/00", dateUpdatedAt: "00/00/00", firstName: "Billy", lastName: "Bob", email: "billy@bob.com", profileImageURL: "N/A", userGroceryLists: nil)
    
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
    }
    
    func testDoesFakeUserExist() {
        
        // test nonExistentUser
        let asyncExpectation = expectationWithDescription("doesUserExistTest")
        var testFakeUserSuccess = false
        var testFakeUserStatusCode = 0
        
        RMUser.doesUserExist("\(nonExistingUser.email)", completion: { (userExists, statusCode) in
            testFakeUserSuccess = userExists
            testFakeUserStatusCode = statusCode
            asyncExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertFalse(testFakeUserSuccess, "statusCode: \(testFakeUserStatusCode)")
        }
    }
    
    func testDoesRealUserExist() {
        let asyncExpectation = expectationWithDescription("doesUserExistTest")
        var testRealUserSuccess = false
        var testRealUserStatusCode = 0
        
        RMUser.doesUserExist("\(firstExistingUser.email)", completion: { (userExists, statusCode) in
            testRealUserSuccess = userExists
            testRealUserStatusCode = statusCode
            asyncExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testRealUserSuccess, "statusCode: \(testRealUserStatusCode)")
        }
    }
    
    func testCreateUser() {
        let asyncExpectation = expectationWithDescription("createUserTest")
        var testCreatedUserSuccess = false
        
        RMUser.createUser(nonExistingUser) { (success) in
            testCreatedUserSuccess = success
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testCreatedUserSuccess)
        }
    }
    
    
    
    func testIfUserDoesntExistThenCreateAndRetrieveUser() {
        let asyncExpectation = expectationWithDescription("ifUserDoesntExistThenCreateUserTest")
        var testSuccess = false
        
        
        RMUser.doesUserExist("\(nonExistingUser.email)") { (userExists, statusCode) in
            if(userExists) {
                RMUser.createUser(self.nonExistingUser) { (success) in
                    testSuccess = success
                    asyncExpectation.fulfill()
                }
            }
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
    
    
}
