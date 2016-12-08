//
//  testRMChore.swift
//  roomate
//
//  Created by Aaron Levin on 12/6/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import XCTest
@testable import roomate

class testRMChore: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCreateNewChore() {
        let asyncExpectation = expectationWithDescription("createNewChoreTest")
        let testUser = RMUser.returnTestUser()
        
        let chore = RMChore(choreID: 0, groupID: testUser.groupID!, userID: testUser.userObjectID, title: "XCTest Chore Title", description: "XCTest Chore Description", dateCreated: "00/00/00")
        
        var testCompleted = false
        
        RMChore.createNewChore(chore) { (completed) in
            testCompleted = completed
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testCompleted)
        }

    }
    
    func testCreateRMChoreCompletion() {
        let asyncExpectation = expectationWithDescription("testCreateRMChoreCompletion")
        let testUser = RMUser.returnTestUser()
        let testChore = RMChore(choreID: 0, groupID: testUser.groupID!, userID: testUser.userObjectID, title: "XCTest Chore Completion Title", description: "XCTest Chore Completion Description", dateCreated: "00/00/00")
        var testCompleted = false
        
        testChore.createRMChoreCompletion(testUser) { (completed) in
            if completed {
                testCompleted = completed
                asyncExpectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testCompleted)
        }
    }
    
    func testGetChoresList() {
        let asyncExpectation = expectationWithDescription("testGetChoresList")
        var testSuccess = false
        let user = RMUser.returnTestUser()
        var testChores: [RMChore]? = nil
        
        RMChore.getChores(0, lastid: 0, groupId: user.groupID!) { (chores) in
            if chores.count > 0 {
                testSuccess = true
                testChores = chores
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
            XCTAssertNotNil(testChores)
        }
        
        
        
    }
}
