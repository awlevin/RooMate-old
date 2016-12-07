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
        
        let nonExistingUser = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "00/00/00", dateUpdatedAt: "00/00/00", firstName: "Billy", lastName: "Bob", email: "billy@bob.com", profileImageURL: "N/A", userGroceryLists: nil)

        var testFakeUserSuccess = false
        var testFakeUserStatusCode = 0
        
        let asyncExpectation = expectationWithDescription("doesUserExistTest")
        
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
        
        let existingUser = RMUser(userObjectID: 2, groupID: 2, dateCreatedAt: "00/00/00", dateUpdatedAt: "00/00/00", firstName: "Bucky", lastName: "Badger", email: "bbadger@wisc.edu", profileImageURL: "N/A", userGroceryLists: nil)
        
        RMUser.doesUserExist("\(existingUser.email)", completion: { (userExists, statusCode) in
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
        
        let nonExistingUser = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "", dateUpdatedAt: "", firstName: "Jordan", lastName: "Deren", email: "jderen1@butthole.com", profileImageURL: "N/A", userGroceryLists: [])

        
        RMUser.createUser(nonExistingUser) { (success, statusCode) in
            testCreatedUserSuccess = success
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testCreatedUserSuccess)
        }
    }
    
    func testGetExistingUserByEmail() {
        let asyncExpectation = expectationWithDescription("getUserByEmail")
        var testSuccess = false
        var testUser: RMUser? = nil
        var testStatusCode = 0
        
        RMUser.getUserFromEmail("jderen1@butthole.com") { (success, statusCode, user) in
            testSuccess = success
            testStatusCode = statusCode
            if user != nil { testUser = user! }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess, "\(testStatusCode)")
            XCTAssertNotNil(testUser)
            
            print("User associated with email: \(testUser?.email)... \nUserID: \(testUser?.userObjectID), \nGroupID: \(testUser?.groupID), \nFirstName: \(testUser?.firstName), \nLastName: \(testUser?.lastName), \nDateCreatedAt: \(testUser?.dateCreatedAt), \nDateUpdatedAt: \(testUser?.dateUpdatedAt)")
        }
    }
    
    func testIfUserDoesntExistThenCreateUser() {
        let asyncExpectation = expectationWithDescription("ifUserDoesntExistThenCreateUserTest")
        var testSuccess = false
        
        let nonExistingUser = RMUser(userObjectID: 0, groupID: 0, dateCreatedAt: "", dateUpdatedAt: "", firstName: "Hunter", lastName: "Kooldude", email: "huntington@wisc.edu", profileImageURL: "N/A", userGroceryLists: [])
        
        RMUser.doesUserExist("\(nonExistingUser.email)") { (userExists, statusCode) in
            if(!userExists) {
                RMUser.createUser(nonExistingUser) { (success, statusCode) in
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
