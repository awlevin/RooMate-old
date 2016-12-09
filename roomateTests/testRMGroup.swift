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
    
    func testCreateGroup() {
        let firstAsyncExpectation = expectationWithDescription("createGroupTest1")
        var firstTestSuccess = false
        var firstTestGroupID = 0
        
        RMGroup.createGroup() { (success, groupID) in
            if success {
                firstTestSuccess = success
                firstTestGroupID = groupID!
            }
            firstAsyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(firstTestSuccess, "\(firstTestGroupID)")
        }
    }
    
    func testGetUsersInGroup() {
        let asyncExpectation = expectationWithDescription("getUsersInGroupTest")
        var testSuccess = false
        var testUsers: [RMUser]? = nil
        let groupID = 1
        
        RMGroup.getUsersInGroup(groupID) { (success, users) in
            if success {
                testSuccess = success
                testUsers = users!
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
            XCTAssertNotNil(testUsers)
            print(testUsers)
        }
    }
    
    func testJoinHousehold() {
        let asyncExpectation = expectationWithDescription("joinHouseholdTest")
        var testSuccess = false
        let userID = 3
        let newGroupID = 3
            
        RMGroup.joinHousehold(userID, groupID: newGroupID) { (success) in
            if success {
                testSuccess = success
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
}
