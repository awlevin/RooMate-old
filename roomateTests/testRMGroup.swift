//
//  testRMGroup.swift
//  roomate
//
//  Created by Aaron Levin on 12/6/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest
@testable import roomate

class testRMGroup: XCTestCase {
    
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
    
    func testDoesGroupExist() {
        let asyncExpectation = expectationWithDescription("doesGroupExistTest")
        var groupExistsValue = false
        var testSuccess = false
        
        RMGroup.doesGroupExist(1) { (success, groupExists) in
            if success {
                testSuccess = success
                groupExistsValue = groupExists
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
            XCTAssertTrue(groupExistsValue)
        }
    }
    
    // this method calls createGroup() twice to make sure that the second groupID is 1 greater than its predecessor
    func testCreateGroup() {
        let firstAsyncExpectation = expectationWithDescription("createGroupTest1")
        var firstTestSuccess = false
        var firstTestGroupID = 0
        
        let secondAsyncExpectation = expectationWithDescription("createGroupTest2")
        var secondTestSuccess = false
        var secondTestGroupID = 0
        
        
        RMGroup.createGroup() { (success, groupID) in
            if success {
                firstTestSuccess = success
                firstTestGroupID = groupID!
            }
            firstAsyncExpectation.fulfill()
        }
        
        
        RMGroup.createGroup() { (success, groupID) in
            if success {
                secondTestSuccess = success
                secondTestGroupID = groupID!
            }
            secondAsyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(firstTestSuccess && secondTestSuccess, "\(firstTestGroupID)")
            XCTAssertTrue(secondTestGroupID == (firstTestGroupID + 1), "firstGroupID: \(firstTestGroupID), secondGroupID: \(secondTestGroupID)")
        }
    }
    
    func testGetUsersInGroup() {
        let asyncExpectation = expectationWithDescription("getUsersInGroupTest")
        var testSuccess = false
        var testUsers = nil
        let groupID = 1
        
        RMGroup.getUsersInGroup(groupID) { (success, users) in
            if success {
                testSuccess = success
                testUsers = users
            }
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
            XCTAssertNotNil(testUsers)
            
        }
        
    }
}
