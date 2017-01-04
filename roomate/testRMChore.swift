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
        let chore = RMChore.returnTestChore()
        var testChoreID = 0
        
        var testCompleted = false
        
        RMChore.createNewChore(chore) { (completed, newChoreID) in
            testCompleted = completed
            testChoreID = newChoreID!
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testCompleted, "newChoreID: \(testChoreID)")
        }
    }
    
    func testDeleteChore() {
        let asyncExpectation = expectationWithDescription("testDeleteChore")
        var testSuccess = false
        
        RMChore.deleteChore(48) { (completed) in
            if (completed) {
                testSuccess = completed
            }
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
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
            print(testSuccess)
            print(testChores)
            
            for chore in testChores! {
                print("choreID: \(chore.choreID), choreName: \(chore.title)\n")
            }
        }
    }
    
    // TODO: make updateBefore
    // TODO: make updateAfter
    
    func testCreateRMChoreCompletion() {
        let asyncExpectation = expectationWithDescription("testCreateRMChoreCompletion")
        let testUser = RMUser.returnTestUser()
        let testChore = RMChore.returnTestChore()
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
    
    func testGetChoreCompletions() {
        let asyncExpectation = expectationWithDescription("testGetChoreCompletions")
        var testSuccess = false
        var testChoreCompletions: [RMChoreCompletion]? = nil
        let testChore = RMChore.returnTestChore()
        
        testChore.getRMChoreCompletions { (completed, choreCompletions) in
            if completed {
                testSuccess = true
                testChoreCompletions = choreCompletions
            }
            asyncExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertTrue(testSuccess)
            XCTAssertNotNil(testChoreCompletions)
            print("chore completions: \(testChoreCompletions)")
        }
    }
}
